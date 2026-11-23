-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _LibraryTypes = require(script.Parent.LibraryTypes)
local ModelViewport = require(BuildExperience.Components.Library.ModelViewport)

local Image = Foundation.Image
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

return React.memo(function(arg1) -- name: LibraryTile
    local var1 = Foundation.Hooks.useTokens()
    local yOffset = Foundation.Hooks.useScaledValue(136)
    local yOffset2 = Foundation.Hooks.useScaledValue(168)
    local selectable = arg1.onActivated ~= nil
    local var2 = arg1.tileKey or arg1.itemId or arg1.displayName
    local var3 = arg1.isFolder and arg1.folderPreview == nil
    local model = if arg1.folderPreview ~= nil then arg1.folderPreview.model else arg1.model
    local image = if arg1.folderPreview ~= nil then arg1.folderPreview.image else arg1.thumbnail
    local name = if var3 then IconName.Folder elseif arg1.itemKind == "Sound" then IconName.Speaker elseif arg1.itemKind == "Image" then IconName.Image else IconName.TwoStackedSquares
    local element

    if arg1.itemKind == "Image" and image ~= nil then
        element = React.createElement(
            Image,
            {
                Image = image,
                ScaleType = Enum.ScaleType.Fit,
                tag = "size-full",
                testId = `Library.Tile.{var2}.Image`
            }
        )
    elseif model ~= nil then
        element = React.createElement(ModelViewport, {
            model = model,
            unavailableText = arg1.unavailableText,
            backgroundTransparency = 1,
            size = UDim2.fromScale(1, 1),
            isInteractive = false,
            testId = `Library.Tile.{var2}.Model`
        })
    else
        element = React.createElement(Icon, {
            name = name,
            size = if var3 or arg1.itemKind == "Sound" then var1.Size.Size_900 else IconSize.Large,
            style = var1.Color.Content.Default,
            testId = `Library.Tile.{var2}.Icon`
        })
    end

    local thumbnail = React.createElement(View, {
        LayoutOrder = 1,
        Size = arg1.mediaSize or UDim2.fromScale(1, 0),
        aspectRatio = if arg1.mediaSize == nil then 1 else nil,
        tag = "align-x-center align-y-center radius-medium clip bg-shift-200",
        testId = `Library.Tile.{var2}.MediaFrame`
    }, { Media = element })

    local createElement = React.createElement
    local var6 = View
    local tbl1 = {
        LayoutOrder = arg1.LayoutOrder,
        onActivated = arg1.onActivated,
        selection = { Selectable = selectable },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        Size = 0,
        tag = 0,
        testId = 0
    }
    local size = arg1.Size

    if not size then
        if arg1.compact then
            size = UDim2.fromOffset(var1.Size.Size_2400, yOffset)
        else
            size = UDim2.fromOffset(var1.Size.Size_3000, yOffset2)
        end
    end

    tbl1.Size = size

    tbl1.tag = {
        ["radius-medium"] = true,
        ["col gap-small"] = not arg1.compact
    }
    tbl1.testId = `Library.Tile.{var2}`
    local tbl2 = { Thumbnail = thumbnail, Content = 0 }
    local createElement2 = React.createElement
    local var7 = View
    local tbl3 = {
        LayoutOrder = 2,
        tag = {
            ["col position-bottom-left anchor-bottom-left size-full-800"] = arg1.compact,
            ["col size-full-0 auto-y"] = not arg1.compact
        },
        testId = `Library.Tile.{var2}.Content`
    }
    local tbl4 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = arg1.displayName,
            TextYAlignment = Enum.TextYAlignment.Top,
            Size = UDim2.new(1, 0, 0, if arg1.compact then var1.Size.Size_600 else var1.Size.Size_1000),
            tag = "text-title-medium text-align-x-left text-truncate-end content-emphasis"
        })
    }
    tbl2.Content = createElement2(var7, tbl3, tbl4)
    return createElement(var6, tbl1, tbl2)
end)
