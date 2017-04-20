# vdk_inventory

> Resources for FiveM allowing the user to access to an inventory and for developpers to add and remove items from the inventory.

## Requirements

- EssentialMode

## Installation

- Download the resource here : https://github.com/vodkhard/vdk_inventory 
- Place the folder "vdk_inventory" to resources folder of FiveM
- Execute dump.sql file in your database (will create the tables and the constraints)
- Change your database configuration in config.lua

## Usage

- For users : Press 'K' to show the menu
- For developers : Use "player:receiveItem" and "player:looseItem" events with the item id and quantity as parameters events to add or remove items from the inventory

## Thanks

https://forum.fivem.net/t/release-gui-script-v0-8

For the menu

## Notes

It's my first LUA script so please be indulgent with me and all valuable proposals are more than welcome.