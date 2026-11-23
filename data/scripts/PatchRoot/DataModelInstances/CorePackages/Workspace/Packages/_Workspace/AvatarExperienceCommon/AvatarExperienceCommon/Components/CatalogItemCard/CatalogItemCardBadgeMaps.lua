-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local _AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)
local BuilderIcons = require(AvatarExperienceCommonParent.BuilderIcons)

local CatalogItemCardItemTypeEnum = require(script.Parent.Enums.CatalogItemCardItemTypeEnum)
local CatalogItemCardItemInfoEnum = require(script.Parent.Enums.CatalogItemCardItemInfoEnum)
local CatalogItemCardStatusIconTypeEnum = require(script.Parent.Enums.CatalogItemCardStatusIconTypeEnum)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXModeratedItemIconUpdates = AvatarExperienceFlags.FFlagAXModeratedItemIconUpdates
local FFlagAXShowFaeUpsell = AvatarExperienceFlags.FFlagAXShowFaeUpsell

local MODERATED_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.CircleI else "icons/actions/info_small"
local PENDING_MODERATION_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.ClockDashed else "icons/status/pending_small"

local DURABLE_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.Clock else "icons/status/pending_small"
local INFO_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.CircleI else "icons/actions/info_small"
local FAE_ICON = if FFlagAXShowFaeUpsell then if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.LockClosed else "icons/status/private" else nil
local UNAVAILABLE_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.CircleI else "icons/status/warning_small"

local ERROR_ICON = if FFlagAXModeratedItemIconUpdates then BuilderIcons.Icon.TriangleExclamation else "icons/status/error_large"

return {
    itemTypeToContentMap = {
        [CatalogItemCardItemTypeEnum.Limited] = {{
            type = "icon",
            icon = "icons/status/item/limited"
        }},
        [CatalogItemCardItemTypeEnum.Collectible] = {
            { type = "icon", icon = "icons/status/item/limited" },
            { type = "text", text = "#" }
        }
    },
    itemInfoIconMap = {
        [CatalogItemCardItemInfoEnum.DynamicHead] = "icons/menu/clothing/dynamicHead"
    },
    itemStatusIconTypeToIconMap = {
        [CatalogItemCardStatusIconTypeEnum.Moderated] = MODERATED_ICON,
        [CatalogItemCardStatusIconTypeEnum.PendingModeration] = PENDING_MODERATION_ICON,
        [CatalogItemCardStatusIconTypeEnum.Durable] = DURABLE_ICON,
        [CatalogItemCardStatusIconTypeEnum.Info] = INFO_ICON,
        [CatalogItemCardStatusIconTypeEnum.Unavailable] = UNAVAILABLE_ICON,
        [CatalogItemCardStatusIconTypeEnum.Error] = ERROR_ICON,
        [CatalogItemCardStatusIconTypeEnum.FAE] = FAE_ICON
    },
    rowItemStatusIconTypeToIconMap = {
        [CatalogItemCardStatusIconTypeEnum.Moderated] = MODERATED_ICON,
        [CatalogItemCardStatusIconTypeEnum.PendingModeration] = PENDING_MODERATION_ICON,
        [CatalogItemCardStatusIconTypeEnum.Unavailable] = UNAVAILABLE_ICON,
        [CatalogItemCardStatusIconTypeEnum.Durable] = DURABLE_ICON
    },
    MODERATED_ICON = MODERATED_ICON,
    PENDING_MODERATION_ICON = PENDING_MODERATION_ICON,
    DURABLE_ICON = DURABLE_ICON,
    INFO_ICON = INFO_ICON,
    FAE_ICON = FAE_ICON,
    UNAVAILABLE_ICON = UNAVAILABLE_ICON,
    ERROR_ICON = ERROR_ICON
}
