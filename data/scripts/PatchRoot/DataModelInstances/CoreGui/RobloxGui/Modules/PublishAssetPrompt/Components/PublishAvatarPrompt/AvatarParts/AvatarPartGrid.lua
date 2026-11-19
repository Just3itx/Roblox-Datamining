-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local GridMetrics = UIBlox.App.Grid.GridMetrics
local DefaultMetricsGridView = UIBlox.App.Grid.DefaultMetricsGridView
local Constants = require(script.Parent.Parent.Parent.Parent.Constants)

local AvatarItemCard = require(script.Parent.AvatarItemCard)
local ItemTile = UIBlox.Tile.ItemTile

local vector2 = Vector2.new(20, 20)

local function createObjectsFolder(tbl1): {Folder} -- Luacid: Inlined by compiler; 5 call sites recovered
    local r15ArtistIntent = Instance.new("Folder")
    r15ArtistIntent.Name = "R15ArtistIntent"
    for _, value in tbl1 do
        value.Parent = r15ArtistIntent
    end
    return { r15ArtistIntent }
end

local function getPart(humanoidModelClone, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (humanoidModelClone:FindFirstChild(str1))
end

local function getItems(humanoidModelClone, _: string)
    local var1 = nil
    local var2 = nil
    local var3 = nil
    for _, child in ipairs(humanoidModelClone:GetChildren()) do
        if not child:IsA("Accessory") then
            continue
        end

        if child.AccessoryType == Enum.AccessoryType.Eyebrow then
            var2 = child
        elseif child.AccessoryType == Enum.AccessoryType.Eyelash then
            var1 = child
        elseif child.AccessoryType == Enum.AccessoryType.Hair then
            var3 = child
        end
    end

    local tbl1 = {
        {
            asset = getPart(humanoidModelClone, "Head"),
            partName = "Head"
        },
        {
            asset = createObjectsFolder(
                { humanoidModelClone:FindFirstChild("UpperTorso"), (humanoidModelClone:FindFirstChild("LowerTorso")) }
            ),
            partName = "Torso"
        },
        {
            asset = createObjectsFolder({ humanoidModelClone:FindFirstChild("LeftUpperArm"), humanoidModelClone:FindFirstChild("LeftLowerArm"), (humanoidModelClone:FindFirstChild("LeftHand")) }),
            partName = "Left Arm"
        },
        {
            asset = createObjectsFolder({ humanoidModelClone:FindFirstChild("LeftUpperLeg"), humanoidModelClone:FindFirstChild("LeftLowerLeg"), (humanoidModelClone:FindFirstChild("LeftFoot")) }),
            partName = "Left Leg"
        },
        {
            asset = createObjectsFolder({ humanoidModelClone:FindFirstChild("RightUpperArm"), humanoidModelClone:FindFirstChild("RightLowerArm"), (humanoidModelClone:FindFirstChild("RightHand")) }),
            partName = "Right Arm"
        },
        {
            asset = createObjectsFolder({ humanoidModelClone:FindFirstChild("RightUpperLeg"), humanoidModelClone:FindFirstChild("RightLowerLeg"), (humanoidModelClone:FindFirstChild("RightFoot")) }),
            partName = "Right Leg"
        }
    }

    if var2 then
        table.insert(tbl1, { asset = var2, partName = "Eyebrows" })
    end

    if var1 then
        table.insert(tbl1, { asset = var1, partName = "Eyelashes" })
    end

    if var3 then
        table.insert(tbl1, { asset = var3, partName = "Hair" })
    end

    return tbl1
end

local function AvatarPartGrid(tbl1)
    local items, var2 = React.useState({})
    React.useEffect(function()
        if tbl1.humanoidModel then
            local humanoidModelClone = tbl1.humanoidModel:Clone()
            var2((getItems(humanoidModelClone, tbl1.name)))
            return
        end

        local tbl2 = ({})
        for i = 1, 6 do
            tbl2[i] = {}
        end
        var2(tbl2)
    end, { tbl1.humanoidModel })

    React.useEffect(function()
        if not items[1] or not items[1].asset then
            return
        end

        local tbl2 = ({})

        for value, value2 in items do
            local tbl3 = {
                asset = value2.asset,
                partName = value2.partName
            }
            tbl2[value] = tbl3
        end

        var2(tbl2)
    end, { tbl1.name })

    local var3 = if tbl1.screenSize.Y > tbl1.screenSize.X then Constants.ItemCardWidthPortrait else Constants.ItemCardWidthLandscape

    local renderItem = React.useCallback(function(arg1)
        if not arg1.asset then
            return React.createElement(ItemTile)
        end

        return React.createElement(
            AvatarItemCard,
            {
                asset = arg1.asset,
                bodyName = tbl1.name,
                partName = arg1.partName,
                viewportSize = var3
            }
        )
    end, { var3, tbl1.name })

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.LayoutOrder,
        BackgroundTransparency = 1
    }, {
        Grid = React.createElement(DefaultMetricsGridView, {
            getItemHeight = function(num1: number): number
                return num1 * (4 / 3)
            end,
            getItemMetrics = GridMetrics.makeCustomMetricsGetter({ minimumItemsPerRow = 2, minimumItemWidth = var3 }),
            renderItem = renderItem,
            itemPadding = vector2,
            items = items
        })
    })
end

return AvatarPartGrid
