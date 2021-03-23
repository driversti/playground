# Java Core

#### Why should we prefer using _try-with-resources_ instead of _try-finally_?

The main point of try-with-resources is to make sure resources are closed reliably without possibly losing information.

When you don't use try-with-resources there's a potential pitfall called exception-masking. When code in a try block throws an exception, and the close method in the finally also throws an exception, the exception thrown by the try block gets lost, and the exception thrown in the finally gets propagated.
[Credits](https://stackoverflow.com/a/26516323/5267610)



