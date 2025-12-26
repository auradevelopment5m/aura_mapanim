---@diagnostic disable: undefined-global
local Config = require('shared.config')

local MAP_PROP = Config.mapProp
local ANIM_DICT = Config.animDict
local ANIM_NAME = Config.animName
local BONE_INDEX = Config.boneIndex
local ATTACH_OFFSET = Config.attachOffset
local ATTACH_ROTATION = Config.attachRotation

MapToggle = {}

function MapToggle:new()
    local obj = {
        is_pause_menu_active = false,
        map_prop_object = nil,
        enabled = true
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function MapToggle:loadModel(model)
    return lib.requestModel(model)
end

function MapToggle:loadAnimDict(dict)
    return lib.requestAnimDict(dict)
end

function MapToggle:startAnimation()
    if not self.enabled then return end
    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) then return end

    if not self:loadModel(MAP_PROP) then return end
    if not self:loadAnimDict(ANIM_DICT) then return end

    local playerCoords = GetEntityCoords(playerPed)
    self.map_prop_object = CreateObject(GetHashKey(MAP_PROP), playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

    if DoesEntityExist(self.map_prop_object) then
        AttachEntityToEntity(self.map_prop_object, playerPed, BONE_INDEX, 
            ATTACH_OFFSET.x, ATTACH_OFFSET.y, ATTACH_OFFSET.z, 
            ATTACH_ROTATION.x, ATTACH_ROTATION.y, ATTACH_ROTATION.z, 
            true, true, false, true, 1, true)
        
        if IsEntityAttached(self.map_prop_object) then
            TaskPlayAnim(playerPed, ANIM_DICT, ANIM_NAME, 8.0, -8.0, -1, 49, 0, false, false, false)
        else
            if Config.enableDebug then
                print("Failed to attach map to player")
            end
            DeleteObject(self.map_prop_object)
            self.map_prop_object = nil
        end
    else
        if Config.enableDebug then
            print("Failed to create map object")
        end
    end
end

function MapToggle:stopAnimation()
    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
        ClearPedTasks(playerPed)
    end
    RemoveAnimDict(ANIM_DICT)

    if DoesEntityExist(self.map_prop_object) then
        DetachEntity(self.map_prop_object, true, true)
        DeleteObject(self.map_prop_object)
        self.map_prop_object = nil
    end
end




function MapToggle:toggle()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_SP_PAUSE'), false, -1)
end

local mapToggleInstance = MapToggle:new()

if Config.enableCommand then
    RegisterCommand(Config.commandName, function()
        mapToggleInstance:toggle()
    end, false)
end


Citizen.CreateThread(function()
    while true do
        if mapToggleInstance.enabled then
            local pauseMenuState = IsPauseMenuActive()

            if pauseMenuState ~= mapToggleInstance.is_pause_menu_active then
                mapToggleInstance.is_pause_menu_active = pauseMenuState

                if pauseMenuState then
                    mapToggleInstance:startAnimation()
                else
                    mapToggleInstance:stopAnimation()
                end
            end
        end

        Citizen.Wait(Config.checkInterval)
    end
end)