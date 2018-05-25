Credits
-------

toggleAirport is based on this post:

http://hints.macworld.com/article.php?story=20100927161027611

https://www.jamf.com/jamf-nation/discussions/1441/disable-airport-when-ethernet-is-active

Purpose
-------

toggleAirport is a launchd service that toggles Airport power based on the
presence of a wired ethernet signal. The assumption is that if you have wired
ethernet connected, there is no need to keep the Aiport interface active.


Installation
------------

```
sudo cp toggleAirport.sh /Library/Scripts
sudo chown root:wheel /Library/Scripts/toggleAirport.sh
sudo chmod 0755 /Library/Scripts/toggleAirport.sh

sudo cp com.envieidoc.toggleAirport.plist /Library/LaunchDaemons
sudo chown root:wheel /Library/LaunchDaemons/com.envieidoc.toggleAirport.plist
sudo chmod 0644 /Library/LaunchDaemons/com.envieidoc.toggleAirport.plist
```

Activation
----------

You'll need to activate the service after it's installed.

```
sudo launchctl load /Library/LaunchDaemons/com.envieidoc.toggleAirport.plist
```

To deactivate, unload it.

```
sudo launchctl unload /Library/LaunchDaemons/com.envieidoc.toggleAirport.plist
```

To deactivate it permanently, first unload, then delete the two files we
installed above.


