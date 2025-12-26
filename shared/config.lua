return {
    -- Map and animation settings
    mapProp = "prop_tourist_map_01",
    animDict = "amb@world_human_tourist_map@male@base",
    animName = "base",
    
    -- Attachment settings
    boneIndex = 66,  -- Right Hand
    attachOffset = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    attachRotation = {
        x = 0.0,
        y = 0.0,
        z = 14.951503103293
    },
    
    -- Timing settings
    checkInterval = 300,  -- milliseconds
    
    -- Feature toggles
    enableCommand = true,  -- Allow /togglemap command
    commandName = "togglemap",
    
    -- Debug settings
    enableDebug = true  -- Enable debug traces
}