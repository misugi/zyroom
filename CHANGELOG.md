zyRoom - History of changes
===========================

# version 6.0.0
Work in progress...

# version 5.1.5 (2021-01-20)
Fixed: the status of server is now correct (red/green icon in the top right corner)
Fixed: OpenSSL version 1.0.2u to be compatible with the server security

# version 5.1.4 (2019-01-20)
Fixed: the application is now compatible with secure API (https://api.ryzom.com)

# version 5.1.3 (2017-07-20)
Fixed: initializing dates when loading a log file
Added: volume for new items

# version 5.1.2 (2016-10-27)
Fixed: the log analysis did not read the last line
Fixed: the application completely block during the analysis of the log if the file contained a blank line
Fixed: the log analysis does not work if the file contained the names of the channels (like "UNIVERSE" or "GUILD")
Fixed: the durability of crafted tools have now a correct value (120)
Change: when the log file contains the names of the channels (like "UNIVERSE" or "GUILD"), these names are displayed in the list used to filter messages

# version 5.1.1 (2014-07-12)
Fixed: the durability of NPC tools have now a correct value (100)
Change: it draws the characters with a vest
Change: use the new address http://api.bmsite.net for the Ballistic Mystix API

# version 5.1.0 (2014-05-25)
New: the real values for characteristics of the objects are back!
New: the resistance and protection are now displayed for jewels
New: the magic characteristics are now displayed for amplifiers
New: you can now filter and sort items on the quantity
New: you can now save and clean your log files
New: locked items are now supported and displayed with a padlock
Change: some optimizations on parsing of the log file (faster, less memory)
Fixed: you can now stop parsing of the log file with the Cancel button
Fixed: wrong volume for few items

# version 5.0.0 (2013-12-15)
New: zyRoom is now compatible with the new Ryzom API !!!
Change: review of source code
Change: for log files, when you click on a button, the file is opened in your default text editor
Fixed: bug on few mission materials from prime roots
Fixed: bug when getting the image of an item with sap load

# version 4.1.1 (2012-08-19)
Change: new address to check and download the last available version

# version 4.1.0 (2012-05-05)
New: you can now reset icons for a guild or a character with the button at the top of the list
Fixed: new sap recharges were not displayed because of filter
Fixed: jewels that are looted were not displayed because of filter
Fixed: the default color for an item is now beige (and not white)
Change: an update of the file sheetid.csv
Change: automatic creation of directories
Change: minimal and maximal value for the quality in the filter
Change: initial position for a new guild added in the list

# version 4.0.5 (2012-01-23)
Fixed: money was not displayed when the amount was greater than 2147483647 dappers

# version 4.0.4 (2011-12-16)
Change: an update of the file sheetid.csv

# version 4.0.3 (2011-12-16)
Fixed: problem with decimal separator in some cases

# version 4.0.2 (2011-09-01)
Change: a limit of 30 automatic backups

# version 4.0.1 (2011-08-29)
Fixed: problem with the option "Enable automatic backup" in the trayicon menu

# version 4.0.0 (2011-08-28)
New: a new menu to backup files of your game profile !
New: dappers are now displayed
Fixed: some windows had no the color defined in the options
Fixed: volume of a mount is now 300
Change: bounds have been added on the calendars of the log

# version 3.2.4 (2011-06-13)
New: a home page to describe the /chatLog command
Fixed: the filters were not properly saved in the file

# version 3.2.3 (2011-06-13)
Change: it is now possible to copy text from the web browser

# version 3.2.2 (2011-06-13)
Change: optimized parsing of the log file

# version 3.2.1 (2011-06-13)
New: to parse a log, it is now possible to filter system messages (filters saved in the file "sysfilter.dat")
Change: two time picker to select messages from a log file and the date selection is now at the top of the window
Fixed: problem with the date picker on the first display of the Log menu

# version 3.2.0 (2011-06-12)
New: menu "Log" to parse your log file saved with the /chatLog command in the game !
Change: position of the buttons on the filter window

# version 3.1.8 (2011-02-28)
Change: if an error occured during the call of the API or if the API returns an error message, the tag "API Error" is added to the message
Fixed: problem with a guild that was added with an empty room or without room (an error was displayed at the start of the synchronisation)

# version 3.1.7 (2010-08-19)
Change: items are not displayed if an error occured during synchronization (as a bad key API)

# version 3.1.6 (2010-08-18)
Fixed: problem with the file "index.dat" when the file "string_client.pack" is not defined in options
Fixed: occupation items are now displayed

# version 3.1.5 (2010-08-15)
Fixed: negative bonus were not displayed

# version 3.1.4 (2010-08-15)
Fixed: characteristics for some items were reversed
Fixed: translation of the interface

# version 3.1.3 (2010-07-27)
Fixed: two windows were not translated

# version 3.1.2 (2010-07-23)
Fixed: get supported languages in the options window

# version 3.1.1 (2010-07-21)
Change: new text for resource file "string_client.pack"
Fixed: buttons not disabled when the list is empty
Fixed: language file not up to date
Fixed: error in the options window when the language file "languages.lcf" does not exists
Fixed: exception handling for alerts

# version 3.1.0 (2010-07-14)
New: buttons have now the look Windows Seven !
New: colors for alert messages !
New: option to ignore alerts for catalyser
New: it is now possible to edit value for a monitored object with menu
New: display value in red for a monitored object in the information
Fixed: monitoring objects for a guild had a limit of approximately 650 objects
Fixed: activation of button Apply in the options

# version 3.0.0 (2010-06-20)
New: trayicon to change some options and show information bubble for alerts
New: button to see the alerts
New: monitoring system for volume, durability, quantity, sales, change of season and all objects of a guild vault !!!
Change: time synchronization is now every 3 minutes
Change: decrease the height of a row in the grid of characters
Change: new look for the options window
Fixed: information that has a value of 0 are now displayed

# version 2.1.0 (2010-05-30)
New: new filters for sales, tools, shields and bonus !
New: it is now possible to change the sorting of items !
New: additional information for items !
Change: tabs Information and Craft were merged in one only tab for a better view !
Change: a background color for the item title to indicate ecosystem of the item
Change: appearance of the filter window
Fixed: if expired date is passed for a sale item, the item is not displayed
Fixed: larva and generic materials are now correctly managed

# version 2.0.0 (2010-05-24)
New: characteristics of craft materials !!!
Change: Arial font for the entire application
Change: traduction of some texts in english and german
Change: display of the date of the next change of season
Change: display of the item information
Fixed: price for items in sale
Fixed: quantity for items in sale

# version 1.7.1 (2010-05-19)
New: display the season and the date of the next change !!!
Change: thousand separator for the item price
Change: style of buttons to up/down a character or a guild

# version 1.7.0 (2010-05-16)
New: display of items for sale with price, continent and time left !!!
New: new display for item information
New: it is now possible to sort guilds and characters

# version 1.6.0 (2010-05-14)
New: volume calculation !!!
New: special name for the mount
New: adding information for an item: volume, name, identifier and elements craft
New: the column Character contains now the name, the guild and the server
(for existing characters, please update the character with the button and just click OK)
New: the column Guild contains now the name and the server
(for existing guilds, please update the character with the button and just click OK)
Change: interface improvements
Change: just put the cursor over an item to display information
Change: the column Server has been deleted
Change: the column Synchronization has been deleted
Fixed: kara/kami tools are now displayed

# version 1.5.0 (2009-11-02)
New: image of the character is now displayed !!! (for existing characters, please update the character with the button and just click OK)
Fixed: comment for character was saved but not displayed

# version 1.4.0 (2009-10-25)
New: comment for guild and character
New: it is now possible to select an object to see its information !!! (quality, class, skin, durability, bonus)
New: filter by item category for materials !
Change: optimized sorting items taking into account of the category for materials !
Change: option to save window position has been removed
Change: option to automatically show the Filter window has been removed
Fixed: equipment of the refugee was not displayed

# version 1.3.0 (2009-10-23)
New: adjustment of the items in room and inventory when resize the main window
New: guilds and characters are now sorted by name
New: filter for magic amplifiers
New: auto-update indicator to download the last version if available !
Change: optimized sorting items !
Change: filter window is now integrated in the main window
Change: adjustment of the scrolling speed in room and inventory
Change: filter for weapons - range or melee
Fixed: problem with the filter of light armor that did not display the pants
Fixed: add a filter "others" for equipment to view all items

# version 1.2.0 (2009-10-06)
New: for filter by equipment, you can choose equipement type !
New: for filter by item name, you can search all words or one of the words !
New: filter by item ecosystem and class is possible for equipment !
Change: accents are ignored for the search by item name
Fixed: small problem with equipment filter

# version 1.1.0 (2009-09-30)
New: filter by item name with multiple key-words !!!
New: option to keep the active filter
New: using threads to reduce the synchronization time
New: option to define how many threads are used for the synchronization
Change: number of items above the room/inventory was deleted
Fixed: option "save window positions" is correctly applied

# version 1.0.2 (2009-09-27)
New: option to save position of windows
New: option to automatically show the Filter window
Change: button "Synchronize" was deleted, the synchronization is automatic when viewing the room or inventory
Change: gray for the background color of "string_client.pack" zone because is read-only
Fixed: some translation errors

# version 1.0.1 (2009-09-24)
New: bold font on the active button
Change: "Room" button is now always enabled
Change: tabs for character inventory are renamed Animal 1-4
Fixed: room access when error during synchronization

# version 1.0.0 (2009-09-22)
New: main window can be minimized and maximized !
New: button "Apply" on the options window.
New: number of items is displayed above the room.
New: AGPLv3 logo on the home page.
New: you can double-clic on the list to open room directly.
Change: option "Basic authentication" for proxy connexion is removed.
Fixed: the state of the "Room" button is resolved for character inventory.
Fixed: default selection of the tab for character inventory is resolved !
Fixed: proxy activation is resolved.

# version 0.0.2 (2009-09-22)
New: you can manage characters now !
Fixed: the color for the filter windows is resolved.
Fixed: the state of the "Room" button is resolved.