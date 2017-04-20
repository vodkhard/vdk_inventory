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

        -- Pour test l'ajout
        --[[if IsControlJustPressed(1, Keys["L"]) then
            Chat("L pressed")
            TriggerEvent("player:receiveItem", 5, 22)
        elseif IsControlJustPressed(1, Keys["M"]) then
            Chat("M pressed")
            TriggerEvent("player:looseItem", 7, 2)
        end]]--
    end
end)

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end