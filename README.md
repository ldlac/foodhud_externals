# Deprecated, Old FiveM System

# foodhud

## Requirements

- **EssentialMode**
- **foodhud** https://drive.google.com/file/d/0B4xRHUr3JifOS0RLTmhhdFNaaEE/view

## Credits
### vdk_inventory https://github.com/vodkhard/vdk_inventory
### gb_needs https://github.com/gabsgold/gb_needs

## Changelog
- **2017-05-19 V0.1**
Released first version

- **2017-05-19 V0.1.1**
Added a config file!
Added more informations in the post.
Now in a zip file, easier to install.

- **2017-05-20 V0.2**
Added GlobalMultiplier in the config file!
Added animations for Drinking and Eating.
Now you die when you reach 51% of your health (Regeneration was preventing the death of the player)
When you die, your needs are replenish

- **2017-05-20 V0.3**
Added External resources that I modified to be able to integrate my foodhud. **vdk_inventory**, **gb_needs**
There is some shop missing in gb_needs. If you someone want to contribute, you are welcome to.

- **2017-05-20 V0.3.1**
Release a modified version of frfuel to prevent it from crashing on client start. (Main link)
Fixed (Trying to) the DataReader mysql error causing by gb_foodshops (github)
Moved changedlog on github.

## Installation

- Download the resource here : https://github.com/ldlac/foodhud_externals
- Place the folder "vdk_inventory" and "gb_foodshops" to resources folder of FiveM
- Execute _modified.sql_ file in your database (will create the tables, the constraints and add some examples items)
- If you already have vdk_inventory installed, there is two fields to add in the `items` table "value" and "type"
- **DON'T FORGET TO MATCH THE ID IN THE SCRIPT WITH THE ONE IN YOUR DATABASE**
- Change your database configuration in _config.lua_
- Populate the `items` and user `user_inventory` tables to test

- Add your items to the Database. id - libelle - value (%gain) - type (1 drink, 2 eat)
- Modify the array in _fooditems_sv.lua_ to match your database
- Modify the buttons in _foodGUI.lua_ to match your database - Starting at line : 183 **DON'T FORGET TO MATCH THE ID IN THE SCRIPT WITH THE ONE IN YOUR DATABASE**

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

##Modification to vdk_inventory

`vdkinv.lua`
```
function ItemMenu(itemId)
    ClearMenu()
    MenuTitle = "Details:"
    Menu.addButton("Utiliser", "use", itemId)
    Menu.addButton("Donner", "give", itemId)
end

function use(item)
    if (ITEMS[item].quantity - 1 >= 0) then
        -- Nice var swap for nothing
        TriggerEvent("player:looseItem", item, 1)
        TriggerServerEvent("item:updateQuantity", 1, item)
        -- Calling the Hunger/Thirst
        if ITEMS[item].type == 2 then
            TriggerEvent("food:eat", ITEMS[item])
        elseif ITEMS[item].type == 1 then
            TriggerEvent("food:drink", ITEMS[item])
        else
            -- Any other type? Drugs??????
            Toxicated()
            Citizen.Wait(7000)
            ClearPedTasks(GetPlayerPed(-1))
            Reality()
        end
    end
end




--------------------------------------------------------
function Toxicated()
	  Citizen.Wait(5000)
	  DoScreenFadeOut(1000)
	  Citizen.Wait(1000)
	  ClearPedTasksImmediately(GetPlayerPed(-1))
	  SetTimecycleModifier("spectator5")
	  SetPedMotionBlur(GetPlayerPed(-1), true)
	  SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	  SetPedIsDrunk(GetPlayerPed(-1), true)
	  DoScreenFadeIn(1000)
end

function Reality()
  Citizen.Wait(50000)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(GetPlayerPed(-1), 0)
  SetPedIsDrunk(GetPlayerPed(-1), false)
  SetPedMotionBlur(GetPlayerPed(-1), false)
end

```

`server.lua`
```
AddEventHandler("item:getItems", function()
    items = {}
    local player = getPlayerID(source)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = '@username'", { ['@username'] = player })
    local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id', 'value', 'type' }, "item_id")
    if (result) then
        for _, v in ipairs(result) do
            t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle, ["value"] = v.value , ["type"] = v.type }
            table.insert(items, tonumber(v.item_id), t)
        end
    end
    TriggerClientEvent("gui:getItems", source, items)
end)
```
