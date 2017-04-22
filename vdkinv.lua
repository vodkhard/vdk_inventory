ITEMS = {}

AddEventHandler("playerSpawned", function()
    RegisterNetEvent("item:getItems")
    TriggerServerEvent("item:getItems")
end)

RegisterNetEvent("gui:getItems")
AddEventHandler("gui:getItems", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
end)

AddEventHandler("player:receiveItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item] == nil) then
        new(item, quantity)
    else
        add({ item, quantity })
    end
end)

AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item].quantity >= quantity) then
        delete({ item, quantity })
    else
        Chat("Vous n'avez pas assez de ressources")
    end
end)

AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sell({ item, price })
    end
end)

function sell(arg)
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - 1
    RegisterNetEvent("item:sell")
    TriggerServerEvent("item:sell", itemId, item.quantity, price)
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - qty
    RegisterNetEvent("item:updateQuantity")
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity + qty
    RegisterNetEvent("item:updateQuantity")
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
    InventoryMenu()
end

function new(item, quantity)
    RegisterNetEvent("item:setItem")
    TriggerServerEvent("item:setItem", item, quantity)
    TriggerServerEvent("item:getItems")
end

function getQuantity(itemId)
    return ITEMS[tonumber(itemId)].quantity
end

function InventoryMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "Items:"
    ClearMenu()
    for ind, value in pairs(ITEMS) do
        if (value.quantity > 0) then
            Menu.addButton(tostring(value.libelle) .. " : " .. tostring(value.quantity), "ItemMenu", ind)
        end
    end
end

function ItemMenu(itemId)
    MenuTitle = "Details:"
    ClearMenu()
    Menu.addButton("Supprimer 1", "delete", { itemId, 1 })
    Menu.addButton("Ajouter 1", "add", { itemId, 1 })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 311) then
            InventoryMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI() -- Draw menu on each tick if Menu.hidden = false
        if IsEntityDead(PlayerPedId()) then
            RegisterNetEvent("item:reset")
            TriggerServerEvent("item:reset")
        end
    end
end)

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end