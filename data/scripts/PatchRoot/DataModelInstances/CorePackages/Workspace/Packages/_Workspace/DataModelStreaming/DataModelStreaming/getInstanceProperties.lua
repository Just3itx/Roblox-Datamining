-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    GuiBase2d = {
        "AbsolutePosition",
        "AbsoluteRotation",
        "AbsoluteSize",
        "AutoLocalize",
        "ClippedRect",
        "IsNotOccluded",
        "RawRect2D",
        "ReplicatedInsertionOrder",
        "RootLocalizationTable",
        "SelectionBehaviorDown",
        "SelectionBehaviorLeft",
        "SelectionBehaviorRight",
        "SelectionBehaviorUp",
        "SelectionGroup",
        "TotalGroupScale"
    },
    GuiObject = {
        "Active",
        "AnchorPoint",
        "AutomaticSize",
        "BackgroundColor",
        "BackgroundColor3",
        "BackgroundTransparency",
        "BorderColor",
        "BorderColor3",
        "BorderMode",
        "BorderSizePixel",
        "ClipsDescendants",
        "Draggable",
        "GuiState",
        "Interactable",
        "LayoutOrder",
        "NextSelectionDown",
        "NextSelectionLeft",
        "NextSelectionRight",
        "NextSelectionUp",
        "Position",
        "Rotation",
        "Selectable",
        "SelectionImageObject",
        "SelectionOrder",
        "SelectionRect2D",
        "Size",
        "SizeConstraint",
        "Transparency",
        "Visible",
        "ZIndex"
    },
    TextLabel = {
        "Confidential",
        "ContentText",
        "Font",
        "FontFace",
        "LineHeight",
        "LocalizationMatchIdentifier",
        "LocalizationMatchedSourceText",
        "LocalizedText",
        "MaxVisibleGraphemes",
        "OpenTypeFeatures",
        "OpenTypeFeaturesError",
        "RichText",
        "Text",
        "TextBounds",
        "TextColor3",
        "TextDirection",
        "TextFits",
        "TextScaled",
        "TextSize",
        "TextStrokeColor3",
        "TextStrokeTransparency",
        "TextTransparency",
        "TextTruncate",
        "TextWrapped",
        "TextXAlignment",
        "TextYAlignment"
    },
    TextButton = {
        "Confidential",
        "ContentText",
        "Font",
        "FontFace",
        "LineHeight",
        "LocalizationMatchIdentifier",
        "LocalizationMatchedSourceText",
        "LocalizedText",
        "MaxVisibleGraphemes",
        "OpenTypeFeatures",
        "OpenTypeFeaturesError",
        "RichText",
        "Text",
        "TextBounds",
        "TextColor3",
        "TextDirection",
        "TextFits",
        "TextScaled",
        "TextSize",
        "TextStrokeColor3",
        "TextStrokeTransparency",
        "TextTransparency",
        "TextTruncate",
        "TextWrapped",
        "TextXAlignment",
        "TextYAlignment"
    },
    TextBox = {
        "ClearTextOnFocus",
        "Confidential",
        "ContentText",
        "CursorPosition",
        "Font",
        "FontFace",
        "LineHeight",
        "LocalizationMatchIdentifier",
        "LocalizationMatchedSourceText",
        "LocalizedText",
        "ManualFocusRelease",
        "MaxVisibleGraphemes",
        "MultiLine",
        "OpenTypeFeatures",
        "OpenTypeFeaturesError",
        "OverlayNativeInput",
        "PlaceholderColor3",
        "PlaceholderText",
        "ReturnKeyType",
        "RichText",
        "SelectionStart",
        "ShouldEmitReturnEvents",
        "ShouldEmitUpAndDownArrowEvents",
        "ShowNativeInput",
        "Text",
        "TextBounds",
        "TextColor3",
        "TextDirection",
        "TextEditable",
        "TextFits",
        "TextInputType",
        "TextScaled",
        "TextSize",
        "TextStrokeColor3",
        "TextStrokeTransparency",
        "TextTransparency",
        "TextTruncate",
        "TextWrapped",
        "TextXAlignment",
        "TextYAlignment"
    },
    ImageLabel = {
        "BackgroundTransparency",
        "ContentImageSize",
        "Image",
        "ImageColor3",
        "ImageRectOffset",
        "ImageRectSize",
        "ImageTransparency",
        "IsLoaded",
        "ResampleMode",
        "ScaleType",
        "SliceCenter",
        "SliceScale",
        "TileSize"
    },
    ImageButton = {
        "BackgroundTransparency",
        "ContentImageSize",
        "HoverImage",
        "Image",
        "ImageColor3",
        "ImageRectOffset",
        "ImageRectSize",
        "ImageTransparency",
        "IsLoaded",
        "PressedImage",
        "ResampleMode",
        "ScaleType",
        "SliceCenter",
        "SliceScale",
        "TileSize"
    },
    Frame = { "BackgroundTransparency", "Style" },
    ScrollingFrame = {
        "AbsoluteCanvasSize",
        "AbsoluteWindowSize",
        "AutomaticCanvasSize",
        "BottomImage",
        "CanvasPosition",
        "CanvasSize",
        "DraggingScrollBar",
        "ElasticBehavior",
        "HorizontalScrollBarInset",
        "HorizontalScrollBarPosition",
        "MidImage",
        "ScrollBarImageColor3",
        "ScrollBarImageTransparency",
        "ScrollBarThickness",
        "ScrollRate",
        "ScrollVelocity",
        "ScrollingDirection",
        "ScrollingEnabled",
        "SmoothScroll",
        "TopImage",
        "VerticalScrollBarInset",
        "VerticalScrollBarPosition"
    },
    LayerCollector = { "Enabled", "ResetOnSpawn", "ZIndexBehavior" }
}

local function getProperty(arg1, str1: string)
    local success, result = pcall(function()
        return arg1[str1]
    end)

    if not success or result == nil then
        return nil
    end

    local function handleInf(num1: number): number | string -- Luacid: Inlined by compiler; 13 call sites recovered
        return if num1 == math.huge then "inf" elseif num1 == -math.huge then "-inf" else num1
    end

    if typeof(result) == "Vector2" then
        return { handleInf(result.X), (handleInf(result.Y)) }
    elseif typeof(result) == "Vector3" then
        return { handleInf(result.X), handleInf(result.Y), (handleInf(result.Z)) }
    elseif typeof(result) == "Color3" then
        return { result.R, result.G, result.B }
    elseif typeof(result) == "UDim2" then
        return {
            handleInf(result.X.Scale),
            handleInf(result.X.Offset),
            handleInf(result.Y.Scale),
            (handleInf(result.Y.Offset))
        }
    elseif typeof(result) == "Rect" then
        return {
            handleInf(result.Min.X),
            handleInf(result.Min.Y),
            handleInf(result.Max.X),
            (handleInf(result.Max.Y))
        }
    elseif typeof(result) == "number" or typeof(result) == "boolean" then
        return result
    end

    return tostring(result)
end

local function getInstanceProperties(arg1, tbl2)
    if not arg1 then
        return {}
    end

    local tbl3 = {
        ClassName = arg1.ClassName,
        Name = arg1.Name
    }

    for value, value2 in tbl1 do
        if not arg1:IsA(value) then
            continue
        end

        for _, value3 in value2 do
            if tbl2 ~= nil and not table.find(tbl2, value3) then
                continue
            end

            local property = getProperty(arg1, value3)
            if property ~= nil then
                tbl3[value3] = property
            end
        end
    end

    for _, tag in (arg1:GetTags()) do
        if string.sub(tag, 1, 12) == "data-testid=" then
            tbl3.TestId = string.sub(tag, 13)
        end
    end

    return tbl3
end

return getInstanceProperties
