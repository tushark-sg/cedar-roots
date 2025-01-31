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


## Routes
| Method | Route(Params/Body) | Description |
| --- | --- | --- |
| GET | `/part?page=<int?>&page_size=<int?>` | Returns the parts index/search page | 
| GET | `/parts?page=<int?>&page_size=<int?>` | Returns the parts as json | 
| GET | `/api/<itemtype_name>` | Returns the items of the `itemtype_name` | 
| GET | `/api/<itemtype_name>/<item_id>` | Return the specified item | 
