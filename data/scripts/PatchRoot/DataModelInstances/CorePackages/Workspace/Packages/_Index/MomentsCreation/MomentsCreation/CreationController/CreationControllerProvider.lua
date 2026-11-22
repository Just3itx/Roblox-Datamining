-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local CreationControllerContext = require(MomentsCreation.CreationController.CreationControllerContext)
local createCreationController = require(MomentsCreation.CreationController.createCreationController)
local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function CreationControllerProvider(tbl1)
    local host = tbl1.host
    local excludeGallery = tbl1.excludeGallery
    local initialAvatarMoment = tbl1.initialAvatarMoment

    local value = React.useMemo(function()
        return createCreationController({
            store = GetCreationFlowStore(false),
            host = host,
            excludeGallery = excludeGallery,
            initialAvatarMoment = initialAvatarMoment
        })
    end, { host, excludeGallery, initialAvatarMoment })

    return React.createElement(CreationControllerContext.Provider, { value = value }, tbl1.children)
end

return CreationControllerProvider
