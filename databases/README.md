# Playing with databases

### Optimistic & Pessimistic locking

**Optimistic Locking** is a strategy where you read a record, take note of a version number (other methods to do this involve dates, timestamps or checksums/hashes) and check that the version hasn't changed before you write the record back. When you write the record back you filter the update on the version to make sure it's atomic. (i.e. hasn't been updated between when you check the version and write the record to the disk) and update the version in one hit.

**Pessimistic Locking** is when you lock the record for your exclusive use until you have finished with it.
[Credits](https://stackoverflow.com/a/129397/5267610)

---

### Flyway vs. Liquibase

#### Flyway

Flyway supports migration scripts in SQL and Java format only

_migrate_ - migrates sql scripts (Java migrations)

_info_ - command shows all currently available migration scripts from the specified folder and lists which scripts have already been applied and which are still due to be applied on the target database.

_validate_ - checks if the migration scripts that were applied to the target database have been changed in the meantime.

_repair_ - resets the database table used by Flyway to store which scripts have been applied (this table is called SCHEMA_VERSION by default)

_clean_ command empties the target schema completely (should only be used on test databases, obviously)

_baseline_ - Baseline is for introducing Flyway to existing databases by baselining them at a specific version. This will cause Migrate to ignore all migrations up to and including the baseline version. Newer migrations will then be applied as usual.

_undo_ - undoes the most recently applied versioned migration. If target is specified, Flyway will attempt to undo versioned migrations in the order they were applied until it hits one with a version below the target. If group is active, Flyway will attempt to undo all these migrations within a single transaction. If there is no versioned migration to undo, calling undo has no effect.

Liquibase supports migration scripts in XML, YAML and JSON format. In these scripts you define the changes to a database on an abstract level. When executed, Liquibase automatically applies all scripts that have not yet been applied and stores the metadata for all applied scripts in a special database table - very similar to Flyway. Also very similar to Flyway, Liquibase can be called via command line, build tools or directly via its Java API.


Flyway uses SQL to define database changes, and thus you can tailor your SQL scripts to work well with the underlying database technology like Oracle or PostgreSQL. With Liquibase on the other hand, you can introduce an abstraction layer by using XML, YAML or JSON to define your database changes. Thus, Liquibase is better suited to be used in a software product that is installed in different environments with different underlying database technologies. If you want to have full control over your SQL, however, Flyway is the tool of choice since you can change the database with fully tailored SQL or even Java code.

[Credits](https://reflectoring.io/database-refactoring-flyway-vs-liquibase/)

---

