# foodhud

## Requirements

- **EssentialMode**

## Credits
# vdk_inventory https://github.com/vodkhard/vdk_inventory
# gb_needs https://github.com/gabsgold/gb_needs

## Installation

- Download the resource here : https://github.com/ldlac/foodhud_externals
- Place the folder "vdk_inventory" and "gb_foodshops" to resources folder of FiveM
- Execute _modified.sql_ file in your database (will create the tables, the constraints and add some examples items)
- If you already have vdk_inventory installed, there is two fields to add in the `items` table "value" and "type"
- Change your database configuration in _config.lua_
- Populate the `items` and user `user_inventory` tables to test

- Add your items to the Database. id - libelle - value (%gain) - type (1 drink, 2 eat)
- Modify the array in _fooditems_sv.lua_ to match your database
- Modify the buttons in _foodGUI.lua_ to match your database - Starting at line : 183

## Usage

- For users : Press your Replay Help Button (usually '**K**') to show the menu
- **E** Near the shop marker
- For developers : Use "**player:receiveItem**" and "**player:looseItem**" events with the item id and quantity as parameters events to add or remove items from the inventory

## Thanks

https://forum.fivem.net/t/release-gui-script-v0-8

_For the menu_

## Notes

These two resources have not been made by me. I modified them to match my foodhud script.
Credits goes to their respective creator.
