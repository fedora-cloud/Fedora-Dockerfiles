Feature: MySQL connection

  Scenario: Root account - positive test
    When mysql container is started
    Then mysql connection with parameters can be established:
          | param          | value         |
          | MYSQL_USER     | root          |
          | MYSQL_PASSWORD | mysqlPassword |
          | MYSQL_DATABASE | testdb        |

  Scenario Outline: Incorrect connection data for root account
    When mysql container is started
    Then mysql connection with parameters can not be established:
          | param          | value      |
          | MYSQL_USER     | root       |
          | MYSQL_PASSWORD | <password> |
          | MYSQL_DATABASE | <db>       |

    Examples:
    | password       | db  |
    | mysqlPassword1 | testdb  |
    | mysqlPassword  | testdb1 |
    | '              | testdb  |
