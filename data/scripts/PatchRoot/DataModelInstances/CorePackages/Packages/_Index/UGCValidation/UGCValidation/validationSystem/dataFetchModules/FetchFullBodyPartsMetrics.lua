-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)

local module = {}

function module.getData(arg1)
    local rootInstance = arg1.rootInstance
    local renderMeshesData = arg1.renderMeshesData
    if not renderMeshesData then
        return {}
    end

    local tbl1 = {}
    for _, child in rootInstance:GetChildren() do
        if child:IsA("MeshPart") then
            tbl1[child.Name] = child
        end
    end

    local editableMeshes = ({})
    for value, value2 in renderMeshesData do
        local var1 = rootInstance:FindFirstChild(value, true)
        if not (var1 and value2.editable) then
            continue
        end

        editableMeshes[var1] = {
            MeshId = {
                instance = value2.editable,
                created = false
            }
        }
    end
    local tbl3 = {
        isServer = arg1.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend,
        editableMeshes = editableMeshes
    }

    local var1, _, var2 = BoundsCalculator.calculateIndividualFullBodyPartsData(tbl1, tbl3, nil, false)
    return if var1 then var2 else {}
end

return module
