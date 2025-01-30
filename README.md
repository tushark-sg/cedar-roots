# Usage
1. For your mssql server enable tcp/ip port  https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port?view=sql-server-ver16

Keep the port default (1433)

2. In `application.properties` file
Update in the config:
`spring.datasource.url`
`spring.datasource.username`
`spring.datasource.password` 

Use https://www.aireforge.com/tools/sql-server-connection-string-generator to generate the url 

3. Run using
`./mvnw spring-boot:run`


4. Goto http://localhost:8082

Configured routes
GET  /part
POST /part 
GET  /task
POST /task 
