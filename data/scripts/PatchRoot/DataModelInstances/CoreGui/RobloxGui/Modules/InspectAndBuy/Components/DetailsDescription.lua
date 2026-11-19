-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local scriptParentParent = script.Parent.Parent
local Colors = require(scriptParentParent.Colors)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)

local var1 = Roact.PureComponent:extend("DetailsDescription")

function var1.setText(arg1)
    local assetInfo = arg1.props.assetInfo or {}
    local bool1 = assetInfo.parentBundleId ~= nil

    local bundleInfo = arg1.props.bundleInfo or {}

    if bool1 then
        local bundleId = UtilityFunctions.getBundleId(assetInfo)
        if bundleInfo[bundleId] then
            arg1.description = bundleInfo[bundleId].description or ""
        end
    elseif assetInfo then
        arg1.description = assetInfo.description or ""
    end
end

function var1.init(arg1)
    arg1.description = ""
    arg1.descriptionRef = Roact.createRef()
end

function var1.render(arg1)
    arg1:setText()
    local yOffset = arg1:calculateSize()

    return Roact.createElement("TextLabel", {
        BackgroundTransparency = 1,
        LayoutOrder = 4,
        Size = UDim2.new(1, -20, 0, yOffset),
        Text = arg1.description or "",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextSize = 16,
        TextWrapped = true,
        Font = AppFonts.default:getDefault(),
        TextColor3 = Colors.White,
        [Roact.Ref] = arg1.descriptionRef
    })
end

function var1.calculateSize(arg1)
    if arg1.descriptionRef.current and arg1.props.assetInfo then
        return TextService:GetTextSize(
            arg1.description,
            16,
            AppFonts.default:getDefault(),
            Vector2.new(arg1.descriptionRef.current.AbsoluteSize.X, 5000)
        ).Y
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        view = arg1.view,
        assetInfo = arg1.assets[assetId],
        detailsInformation = arg1.detailsInformation,
        bundleInfo = arg1.bundles
    }
end)(var1)
