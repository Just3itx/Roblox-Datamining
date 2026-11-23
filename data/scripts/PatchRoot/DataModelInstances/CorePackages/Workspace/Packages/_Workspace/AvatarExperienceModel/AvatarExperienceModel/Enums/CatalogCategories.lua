-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceModelParent = script:FindFirstAncestor("AvatarExperienceModel").Parent

local enumerate = require(AvatarExperienceModelParent.enumerate)

local AvatarExperienceFlags = require(AvatarExperienceModelParent.AvatarExperienceFlags)
local FFlagAXCatalogM41Props = AvatarExperienceFlags.FFlagAXCatalogM41Props
local FFlagAXAddHDCatalogTab = AvatarExperienceFlags.FFlagAXAddHDCatalogTab
local FFlagAXCatalogBackgroundsSupport = AvatarExperienceFlags.FFlagAXCatalogBackgroundsSupport

return enumerate(script.Name, {
    Featured = "Featured",
    Recommended = "Recommended",
    Characters = "Characters",
    Avatars = "Avatars",
    Clothing = "Clothing",
    Accessories = "Accessories",
    Head = "Head",
    Body = "Body",
    Makeup = "Makeup",
    AllAnimations = "AllAnimations",
    Emotes = "Emotes",
    Backgrounds = if FFlagAXCatalogBackgroundsSupport then "Backgrounds" else nil,
    Props = if FFlagAXCatalogM41Props then "Props" else nil,
    HighDefinition = if FFlagAXAddHDCatalogTab then "HighDefinition" else nil
})
