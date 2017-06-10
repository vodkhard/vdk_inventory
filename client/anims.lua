function animsMenu()
    MenuTitle = "Animations :"
    ClearMenu()
    Menu.addButton("Animations de Salutations", "animsSub", "salut")
    Menu.addButton("Animations d'Humeurs", "animsSub", "humour")
    Menu.addButton("Animations de Travail", "animsSub", "travail")
    Menu.addButton("Animations Festives", "animsSub", "festives")
    Menu.addButton("Animations Diverses", "animsSub", "autre")
end

local anims = {
    ["festives"] = {
        {"Danser", "animsAction", { lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" }},
        {"Jouer de la musique", "animsActionScenario", {anim = "WORLD_HUMAN_MUSICIAN" }},
        {"Boire une biere", "animsActionScenario", { anim = "WORLD_HUMAN_DRINKING" }},
        {"Air Guitar", "animsAction", { lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" }},
    },
    ["salut"] = {
        {"Saluer", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_hello" }},
        {"Serrer la main", "animsAction", { lib = "mp_common", anim = "givetake1_a" }},
        {"Tape en 5", "animsAction", { lib = "mp_ped_interaction", anim = "highfive_guy_a" }},
        {"Salut Militaire", "animsAction", { lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" }},
    },
    ["travail"] = {
        {"Pêcheur", "animsActionScenario", {anim = "world_human_stand_fishing" }},
        {"Agriculteur", "animsActionScenario", { anim = "world_human_gardener_plant" }},
        {"Dépanneur", "animsActionScenario", { anim = "world_human_vehicle_mechanic" }},
        {"Prendre des notes", "animsActionScenario", { anim = "WORLD_HUMAN_CLIPBOARD" }},
    },
    ["humour"] = {
        {"Féliciter", "animsActionScenario", {anim = "WORLD_HUMAN_CHEERING" }},
        {"Super", "animsAction", { lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" }},
        {"Calme-toi ", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_easy_now" }},
        {"Avoir peur", "animsAction", { lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" }},
        {"C'est pas Possible!", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_damn" }},
        {"Enlacer", "animsAction", { lib = "mp_ped_interaction", anim = "kisses_guy_a" }},
        {"Doigt d'honneur", "animsAction", { lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" }},
        {"Branleur", "animsAction", { lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" }},
        {"Balle dans la tete", "animsAction", { lib = "mp_suicide", anim = "pistol" }},
    },
    ["autre"] = {
        {"Fumer une clope", "animsActionScenario", { anim = "WORLD_HUMAN_SMOKING" }},
        {"S'asseoir", "animsAction", { lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" }},
        {"S'asseoir (Par terre)", "animsActionScenario", { anim = "WORLD_HUMAN_PICNIC" }},
        {"Attendre", "animsActionScenario", { anim = "world_human_leaning" }},
        {"Nettoyer quelque chose", "animsActionScenario", { anim = "world_human_maid_clean" }},
        {"Position de Fouille", "animsAction", { lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" }},
        {"Se gratter les c**", "animsAction", { lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" }},
        {"Prendre un selfie", "animsActionScenario", { anim = "world_human_tourist_mobile" }},
    }
}

function animsSub(cat)
    ClearMenu()
	for _, v in pairs(anims[cat]) do
        Menu.addButton(v[1] , v[2], v[3])
    end
end

function animsAction(animObj)
    RequestAnimDict(animObj.lib)
    while not HasAnimDictLoaded(animObj.lib) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded(animObj.lib) then
        TaskPlayAnim(GetPlayerPed(-1), animObj.lib , animObj.anim ,8.0, -8.0, -1, 0, 0, false, false, false)
    end
end

function animsActionScenario(animObj)
    local ped = GetPlayerPed(-1);

    if ped then
        local pos = GetEntityCoords(ped);
        local head = GetEntityHeading(ped);
        --TaskStartScenarioAtPosition(ped, animObj.anim, pos['x'], pos['y'], pos['z'] - 1, head, -1, false, false);
        TaskStartScenarioInPlace(ped, animObj.anim, 0, false)
        if IsControlJustPressed(1,188) then
        
        end
        Citizen.CreateThread(function()
            while IsPedUsingAnyScenario(ped) do
                Citizen.Wait(5)
                if IsPedUsingAnyScenario(ped) then
                    if IsControlJustPressed(1, 34) or IsControlJustPressed(1, 32) or IsControlJustPressed(1, 8) or IsControlJustPressed(1, 9) then
                        ClearPedTasks(ped)
                    end
                end
            end
        end)
    end
end