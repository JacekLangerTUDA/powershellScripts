

gitPullAll.ps1 
in Ordner kopieren in dem sich sowohl vfl, ms-sql-docker und latex-web-api-docker befinden.
gitPullAll.ps1 ist digital Signiert und müsste funktionieren. Sollte ein Ausführen denoch nicht möglich sein,
sollte man die ausführung externer scripte in der Powershell einstellen.

Dazu startet man die Powershell als Admin und führt 

Set-ExecutionPolicy AllSigned

aus.

Wenn das ausführen immer noch nicht funktioniert muss das Script nochmals Signiert werden.
Dazu muss man den Anweisungen aus Sign Script folgen.