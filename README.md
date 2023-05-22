# ApiCallsUsingCombineZipOperator
Requirement:
- Landing screen we have button and tableview, once tap on button getting the data from two apis dispay the data in tableview

ViewController:
- Design user interface: Show button(get user and posts details) and tableview
- Tableview have two sections with header values , section 0 - Users List, Section 1 - Posts List
- Published subscriber implemented

ViewModel:
- Calling two apis(users and posts) using combine ZIP operator
- Once get the two responses then zip operartor passed data to downstream 
- We have declared @Published property wrapper - allData 

NetworkManager:
- Implemented Api call using Combine - datataskPublisher and  Future


Over All Info:
In landing page when tap on button - calling apis - once data assigned to alldata published wrapper property then immediatly subscriber notified, then refresh the tableview
