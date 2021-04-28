const https = require('https');
const querystring = require('querystring');
const {JSDOM} = require('jsdom');

let loginUrl = 'https://gagadget.com/auth/login/?next=/&_=' + Date.now()

function telegramSender(message) {
  const botToken = process.env.GAGADGET_BOT_TOKEN;
  const telegramId = process.env.TELEGRAM_ID;
  if (botToken && telegramId) {
    const options = {
      hostname: 'api.telegram.org',
      path: `/bot${botToken}/sendMessage`,
      method: 'POST',
      port: 443,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }
    const req = https.request(options, (res) => {
      console.log('>> ', res.statusCode)
      res.on('data',
          chunk => console.log('Response from Telegram: ', chunk.toString()));
      res.on('error', (err) => console.error(err));
      res.on('end', () => console.log("Sent to Telegram."));
    });
    req.on('error', (err) => {
      console.error("Cannot send post to telegram: ", err)
    })
    const pathContent = querystring.stringify(
        {'chat_id': telegramId, 'text': message})
    console.log('>>> ', pathContent)
    req.write(pathContent)
    req.end();
  } else {
    console.error(
        'The message to Telegram won\'t be sent. Bot token is [%s], telegram ID is [%s]',
        botToken, telegramId);
  }
}

function parseToken(html) {
  const dom = new JSDOM(html)
  const all = dom.window.document.querySelectorAll("input");
  const func = x => x.name === 'csrfmiddlewaretoken';
  const token = Array.from(all).find(func).value;
  console.log(token)
  return token;
}

function prepareDataForLogin(token) {
  return querystring.stringify({
    next: "/",
    csrfmiddlewaretoken: token,
    email: process.env.GAGADGET_EMAIL,
    password: process.env.GAGADGET_PASSWORD
  })
}

function prepareRequestForCoinsDialog(res) {
  const cookies = res.headers['set-cookie'];
  // console.log('Cookie => ', cookies)
  const flatten = cookies.flatMap(it => it.split('; '));
  // console.log(flatten);

  const csrftoken = flatten.find(it => it.startsWith('csrftoken'));
  // console.log('csrftoken: ', csrftoken);
  const sessionid = flatten.find(it => it.startsWith('sessionid'));
  // console.log('sessionid: ', sessionid);
  return {
    hostname: 'gagadget.com',
    path: `/users/${process.env.GAGADGET_USER_ID}/settings/ggc/siteentry/lightbox/1-7/?_=${Date.now()}`,
    method: 'GET',
    port: 443,
    headers: {
      'cookie': `${csrftoken}; ${sessionid}; country_filter=ua`,
      'referer': 'https://gagadget.com'
    }
  }
}

function postForCoinsDialog(opt) {
  let coinsDialogHtml = '';
  const req = https.request(opt, (res) => {
    // console.log('coins statusCode:', res.statusCode);
    // console.log('coins headers:', res.headers);
    res.on('data', (coinsData) => {
      coinsDialogHtml += coinsData.toString()
    });
    res.on('end', () => {
      const document = new JSDOM(coinsDialogHtml).window.document;
      let bonusText = document.querySelector("h3").textContent.trim()
      bonusText = bonusText.replace('бонус', 'бонус ')
      let daysRawText = document.querySelector("p").textContent;
      const splitDaysText = daysRawText.split(".")
      const daysText = `${splitDaysText[0]}. ${splitDaysText[1]}`
      const message = `${bonusText}. ${daysText}`;
      console.log(message);
      telegramSender(message);
    })
  });
  req.on('error', (e) => console.error(e))
  req.end();
}

let doLogin = token => {
  const postdata = prepareDataForLogin(token)
  console.log(postdata)
  const options = {
    hostname: 'gagadget.com',
    path: '/auth/login/',
    method: 'POST',
    port: 443,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': postdata.length,
      'Referer': 'https://gagadget.com',
      'Cookie': `csrftoken=${token}`
    }
  };
  const req = https.request(options, res => {
    // console.log('statusCode:', res.statusCode);
    // console.log('headers:', res.headers);
    // res.on('data', (d) => {
    // process.stdout.write(d);
    // console.log(d.toString())
    // });
    res.on('end', () => console.log('Login successful.'))
    const opt = prepareRequestForCoinsDialog(res);
    postForCoinsDialog(opt);
  });
  req.on('error', (e) => {
    console.error(e);
  });
  req.write(postdata);
  req.end();
}

// STARTING HERE
https.get(loginUrl, resp => {
      let html = '';
      resp.on('data', chunk => html += chunk)
      resp.on('end', () => {
        const token = parseToken(html);
        doLogin(token);

      })
    }
).on('error', err => console.log(err))


