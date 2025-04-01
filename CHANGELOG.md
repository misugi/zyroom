# Change Log
All notable changes to this project will be documented in this file.

## [6.0.0]

### Added
- Zig inventories
- Guild chests
- Context menu allowing you to copy an item's ID
- Color for generic raw materials
- Color for refugee armor
- Default beige color for armor
- Characteristics of extra materials
- Acceptance of "x3" catalysts

### Changed
- Complete interface review
- Advanced search to find the Ryzom folder
- No more automatic updates
- Default language "French"
- Update of item volumes
- Strong API key control
- Maximum durability is no longer displayed
- Percentage alert threshold for volume monitoring

### Fixed
- Compatible with the new "string_client.pack" file format
- In some cases, reading protections on jewelry did not work
- Loss of accented characters after filtering on an item's name

## [5.1.5] - 2021-01-20

### Fixed
- the status of server is now correct (red/green icon in the top right corner)
- OpenSSL version 1.0.2u to be compatible with the server security

## [5.1.4] - 2019-01-20

### Fixed
- the application is now compatible with secure API (https://api.ryzom.com)

## [5.1.3] - 2017-07-20

### Added
- volume for new items

### Fixed
- initializing dates when loading a log file

## [5.1.2] - 2016-10-27

### Changed
- when the log file contains the names of the channels (like "UNIVERSE" or "GUILD"), these names are displayed in the list used to filter messages

### Fixed
- the log analysis did not read the last line
- the application completely block during the analysis of the log if the file contained a blank line
- the log analysis does not work if the file contained the names of the channels (like "UNIVERSE" or "GUILD")
- the durability of crafted tools have now a correct value (120)

## [5.1.1] - 2014-07-12

### Changed
- it draws the characters with a vest
- use the new address http://api.bmsite.net for the Ballistic Mystix API

### Fixed
- the durability of NPC tools have now a correct value (100)

## [5.1.0] - 2014-05-25

### Added
- the real values for characteristics of the objects are back!
- the resistance and protection are now displayed for jewels
- the magic characteristics are now displayed for amplifiers
- you can now filter and sort items on the quantity
- you can now save and clean your log files
- locked items are now supported and displayed with a padlock

### Changed
- some optimizations on parsing of the log file (faster, less memory)

### Fixed
- you can now stop parsing of the log file with the Cancel button
- wrong volume for few items

## [5.0.0] - 2013-12-15

### Added
- zyRoom is now compatible with the new Ryzom API !!!

### Changed
- review of source code
- for log files, when you click on a button, the file is opened in your default text editor

### Fixed
- bug on few mission materials from prime roots
- bug when getting the image of an item with sap load

## [4.1.1] - 2012-08-19

### Changed
- new address to check and download the last available version

## [4.1.0] - 2012-05-05

### Added
- you can now reset icons for a guild or a character with the button at the top of the list

### Changed
- an update of the file sheetid.csv
- automatic creation of directories
- minimal and maximal value for the quality in the filter
- initial position for a new guild added in the list

### Fixed
- new sap recharges were not displayed because of filter
- jewels that are looted were not displayed because of filter
- the default color for an item is now beige (and not white)

## [4.0.5] - 2012-01-23

### Fixed
- money was not displayed when the amount was greater than 2147483647 dappers

## [4.0.4] - 2011-12-16

### Changed
- an update of the file sheetid.csv

## [4.0.3] - 2011-12-16

### Fixed
- problem with decimal separator in some cases

## [4.0.2] - 2011-09-01

### Changed
- a limit of 30 automatic backups

## [4.0.1] - 2011-08-29

### Fixed
- problem with the option "Enable automatic backup" in the trayicon menu

## [4.0.0] - 2011-08-28

### Added
- a new menu to backup files of your game profile !
- dappers are now displayed

### Changed
- bounds have been added on the calendars of the log

### Fixed
- some windows had no the color defined in the options
- volume of a mount is now 300

## [3.2.4] - 2011-06-13

### Added
- a home page to describe the /chatLog command

### Fixed
- the filters were not properly saved in the file

## [3.2.3] - 2011-06-13

### Changed
- it is now possible to copy text from the web browser

## [3.2.2] - 2011-06-13

### Changed
- optimized parsing of the log file

## [3.2.1] - 2011-06-13

### Added
- to parse a log, it is now possible to filter system messages (filters saved in the file "sysfilter.dat")

### Changed
- two time picker to select messages from a log file and the date selection is now at the top of the window

### Fixed
- problem with the date picker on the first display of the Log menu

## [3.2.0] - 2011-06-12

### Added
- menu "Log" to parse your log file saved with the /chatLog command in the game !

### Changed
- position of the buttons on the filter window

## [3.1.8] - 2011-02-28

### Changed
- if an error occured during the call of the API or if the API returns an error message, the tag "API Error" is added to the message

### Fixed
- problem with a guild that was added with an empty room or without room (an error was displayed at the start of the synchronisation)

## [3.1.7] - 2010-08-19

### Changed
- items are not displayed if an error occured during synchronization (as a bad key API)

## [3.1.6] - 2010-08-18

### Fixed
- problem with the file "index.dat" when the file "string_client.pack" is not defined in options
- occupation items are now displayed

## [3.1.5] - 2010-08-15

### Fixed
- negative bonus were not displayed

## [3.1.4] - 2010-08-15

### Fixed
- characteristics for some items were reversed
- translation of the interface

## [3.1.3] - 2010-07-27

### Fixed
- two windows were not translated

## [3.1.2] - 2010-07-23

### Fixed
- get supported languages in the options window

## [3.1.1] - 2010-07-21

### Changed
- new text for resource file "string_client.pack"

### Fixed
- buttons not disabled when the list is empty
- language file not up to date
- error in the options window when the language file "languages.lcf" does not exists
- exception handling for alerts

## [3.1.0] - 2010-07-14

### Added
- buttons have now the look Windows Seven !
- colors for alert messages !
- option to ignore alerts for catalyser
- it is now possible to edit value for a monitored object with menu
- display value in red for a monitored object in the information

### Fixed
- monitoring objects for a guild had a limit of approximately 650 objects
- activation of button Apply in the options

## [3.0.0] - 2010-06-20

### Added
- trayicon to change some options and show information bubble for alerts
- button to see the alerts
- monitoring system for volume, durability, quantity, sales, change of season and all objects of a guild vault !!!

### Changed
- time synchronization is now every 3 minutes
- decrease the height of a row in the grid of characters
- new look for the options window

### Fixed
- information that has a value of 0 are now displayed

## [2.1.0] - 2010-05-30

### Added
- new filters for sales, tools, shields and bonus !
- it is now possible to change the sorting of items !
- additional information for items !

### Changed
- tabs Information and Craft were merged in one only tab for a better view !
- a background color for the item title to indicate ecosystem of the item
- appearance of the filter window

### Fixed
- if expired date is passed for a sale item, the item is not displayed
- larva and generic materials are now correctly managed

## [2.0.0] - 2010-05-24

### Added
- characteristics of craft materials !!!

### Changed
- Arial font for the entire application
- traduction of some texts in english and german
- display of the date of the next change of season
- display of the item information

### Fixed
- price for items in sale
- quantity for items in sale

## [1.7.1] - 2010-05-19

### Added
- display the season and the date of the next change !!!

### Changed
- thousand separator for the item price
- style of buttons to up/down a character or a guild

## [1.7.0] - 2010-05-16

### Added
- display of items for sale with price, continent and time left !!!
- new display for item information
- it is now possible to sort guilds and characters

## [1.6.0] - 2010-05-14

### Added
- volume calculation !!!
- special name for the mount
- adding information for an item: volume, name, identifier and elements craft
- the column Character contains now the name, the guild and the server
(for existing characters, please update the character with the button and just click OK)
- the column Guild contains now the name and the server
(for existing guilds, please update the character with the button and just click OK)

### Changed
- interface improvements
- just put the cursor over an item to display information
- the column Server has been deleted
- the column Synchronization has been deleted

### Fixed
- kara/kami tools are now displayed

## [1.5.0] - 2009-11-02

### Added
- image of the character is now displayed !!! (for existing characters, please update the character with the button and just click OK)

### Fixed
- comment for character was saved but not displayed

## [1.4.0] - 2009-10-25

### Added
- comment for guild and character
- it is now possible to select an object to see its information !!! (quality, class, skin, durability, bonus)
- filter by item category for materials !

### Changed
- optimized sorting items taking into account of the category for materials !
- option to save window position has been removed
- option to automatically show the Filter window has been removed

### Fixed
- equipment of the refugee was not displayed

## [1.3.0] - 2009-10-23

### Added
- adjustment of the items in room and inventory when resize the main window
- guilds and characters are now sorted by name
- filter for magic amplifiers
- auto-update indicator to download the last version if available !

### Changed
- optimized sorting items !
- filter window is now integrated in the main window
- adjustment of the scrolling speed in room and inventory
- filter for weapons - range or melee
- problem with the filter of light armor that did not display the pants

### Fixed
- add a filter "others" for equipment to view all items

## [1.2.0] - 2009-10-06

### Added
- for filter by equipment, you can choose equipement type !
- for filter by item name, you can search all words or one of the words !
- filter by item ecosystem and class is possible for equipment !

### Changed
- accents are ignored for the search by item name

### Fixed
- small problem with equipment filter

## [1.1.0] - 2009-09-30

### Added
- filter by item name with multiple key-words !!!
- option to keep the active filter
- using threads to reduce the synchronization time
- option to define how many threads are used for the synchronization

### Changed
- number of items above the room/inventory was deleted

### Fixed
- option "save window positions" is correctly applied

## [1.0.2] - 2009-09-27

### Added
- option to save position of windows
- option to automatically show the Filter window

### Changed
- button "Synchronize" was deleted, the synchronization is automatic when viewing the room or inventory
- gray for the background color of "string_client.pack" zone because is read-only

### Fixed
- some translation errors

## [1.0.1] - 2009-09-24

### Added
- bold font on the active button

### Changed
- "Room" button is now always enabled
- tabs for character inventory are renamed Animal 1-4

### Fixed
- room access when error during synchronization

## [1.0.0] - 2009-09-22

### Added
- main window can be minimized and maximized !
- button "Apply" on the options window.
- number of items is displayed above the room.
- AGPLv3 logo on the home page.
- you can double-clic on the list to open room directly.

### Changed
- option "Basic authentication" for proxy connexion is removed.

### Fixed
- the state of the "Room" button is resolved for character inventory.
- default selection of the tab for character inventory is resolved !
- proxy activation is resolved.

## [0.0.2] - 2009-09-22

### Added
- you can manage characters now !

### Fixed
- the color for the filter windows is resolved.
- the state of the "Room" button is resolved.