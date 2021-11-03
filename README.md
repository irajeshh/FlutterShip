Youtube: https://www.youtube.com/FlutterShipp

How to create release apk?
//normal
`flutter build apk --target-platform android-arm,android-arm64 --split-per-abi`

//if dynamically not changing icons based on their int values on remote
`flutter build apk --target-platform android-arm,android-arm64 --split-per-abi --tree-shake-icons`

//if dynamically changing icons based on their int values on remote
`flutter build apk --target-platform android-arm,android-arm64 --split-per-abi --no-tree-shake-icons`

How to set firebase analytics on debugging mode?
to start:
`adb shell setprop debug.firebase.analytics.app com.app.abc`
to stop:
`adb shell setprop debug.firebase.analytics.app .none.`


How to launch UPI Apps via url link?
`upi://pay?pa=9876543210@okbizaxis&pn=Name&tn= YourNotes &am=1&cu=INR`


How to open startup apps folder in windows 10?
`C:\Users\YourUserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`


How to host a flutter website on a custom domain on firebase?
To deploy in the default firebase domain:
`flutter build web`
`firebase deploy`
To deploy in specific domain
`firebase target:apply hosting typeAName typename.com`
`firebase deploy --only hosting:typeAName`

For a newly created domain:
`add "site": "yourwebsite", in firebase.json file that exists on the folder`
`flutter build web`
`firebase deploy --only hosting:yourwebsite`


How to deploy your first function on firebase?
`firebase deploy`

How to deploy second or third function on firebase?
`firebase deploy --only functions:paymentAlerts`
//functionName means the name you are givin in your code:
_`exampe export.paymentAlerts = admin........`_


How to create debugging key?
open cmd and type `cd C:\Program Files\Java\jdk-16.0.1\bin`
`keytool -genkey -v -keystore debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000`
_Note: change your java verison manually exploring to c:\program files\java\_

How to get debugging sha1 certificate?
`cd C:\Program Files\Java\jdk1.8.0_291\bin`
_Note: change your java verison manually exploring to c:\program files\java\_


How to get realse keystore file?
open cmd and type this
`cd C:\Program Files\Java\jdk1.8.0_291\bin`

type the below
`keytool -genkey -v -keystore D:\yourappname.jks -keyalg RSA -keysize 2048 -validity 10000 -alias yourappname`
`password:` yourapppassword
`first name last name:` yourname
`unit name:` any
`org name:` any
`city name:` yourcity
`state name:` yourstate
`code:` yourcountrycode
finaly type `y` or yes, if you made any mistake then type `n`

How to get sha1 from generated keyfile?
open cmd and type this
`cd C:\Program Files\Java\jdk1.8.0_291\bin`
and type the following
`keytool -list -v -keystore D:\yourappname.jks -alias yourappname`


How to add git to a folder via vscode in a simple method?
first create a repository in git
now open your folder in vscode
open terminal in vscode
type the following:
`git init`
`git remote add origin https://github.com/yourgitusername/yourrepositoryname.git`

How to remove git from a local project folder and subfolders?
open cmd on that folder or its parent folder and type the following
`rd .git /S/Q`


How to clone a github branch?
`git clone -b branchname https://git@github.com/yourgitusername/repositoryname.git`

How to remove a line which starts with a specific word in vscode?
`^.*print.*$\n`

How to remove all charater after a specific character in vscode?
`=.*?; eg:<.*?>`

//More things I found usefull will be update here. Have a great day
