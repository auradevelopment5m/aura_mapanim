local isPauseMenuActive = false
local mapProp = "prop_tourist_map_01"
local mapPropObject = nil
local animDict = "amb@world_human_tourist_map@male@base"
local animName = "base"

local function loadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

local function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

local function startMapAnimation()
    local playerPed = PlayerPedId()
    
    loadModel(mapProp)
    loadAnimDict(animDict)

    local playerCoords = GetEntityCoords(playerPed)
    mapPropObject = CreateObject(GetHashKey(mapProp), playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
    
    if DoesEntityExist(mapPropObject) then
        local boneIndex = GetPedBoneIndex(playerPed, 28422) -- Right Hand
        
        AttachEntityToEntity(mapPropObject, playerPed, boneIndex, 
            0.11734371230796, 0.10996638210045, 0.031427339906436, 
            135.75262618374, 9.3033500212994, 51.877293346622, 
            true, true, false, true, 1, true)
        
        if IsEntityAttached(mapPropObject) then
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)
        else
            print("Failed to attach map to player")
            DeleteObject(mapPropObject)
            mapPropObject = nil
        end
    else
        print("Failed to create map object")
    end
end

local function stopMapAnimation()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    RemoveAnimDict(animDict)
    
    if DoesEntityExist(mapPropObject) then
        DetachEntity(mapPropObject, true, true)
        DeleteObject(mapPropObject)
        mapPropObject = nil
    end
end

Citizen.CreateThread(function()
    while true do
        local pauseMenuState = IsPauseMenuActive()
        
        if pauseMenuState ~= isPauseMenuActive then
            isPauseMenuActive = pauseMenuState
            
            if isPauseMenuActive then
                startMapAnimation()
            else
                stopMapAnimation()
            end
        end
        
        Citizen.Wait(300)
    end
end)
--w
