-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local Analytics = require(scriptParentParent.Analytics)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local tbl1 = { "InnerCage", "OuterCage" }
local tbl2 = { "ReferenceMeshId", "CageMeshId" }
local tbl3 = { Analytics.ErrorType.validateLayeredClothingAccessory_NoInnerCageId, Analytics.ErrorType.validateLayeredClothingAccessory_NoOuterCageId }

local function getCageMeshInfos(arg1, arg2)
    local wrapLayer = arg1:FindFirstChild("Handle"):FindFirstChildOfClass("WrapLayer")
    local tbl4 = {}
    local tbl5 = {}

    if not wrapLayer then
        return false, { "Missing wraplayer" }, nil
    end

    local tbl6 = { wrapLayer.ReferenceMeshId, wrapLayer.CageMeshId }

    for value, fieldName in tbl2 do
        local tbl7 = {
            fullName = string.format("%s %s", wrapLayer:GetFullName(), tbl1[value]),
            fieldName = fieldName,
            contentId = tbl6[value],
            context = arg1.Name
        }

        if (tbl7.contentId == "" or tbl7.contentId == nil) and not arg2.allowEditableInstances then
            Analytics.reportFailure(tbl3[value], nil, arg2)
            table.insert(
                tbl5,
                string.format(
                    "Missing %s (i.e. invalid %s) on layered clothing accessory '%s'. Make sure you are using a valid meshId and try again.\n",
                    tbl1[value],
                    fieldName,
                    arg1.Name
                )
            )
        else
            local var1, editableMesh = getEditableMeshFromContext(wrapLayer, fieldName, arg2)

            if not var1 then
                table.insert(
                    tbl5,
                    string.format(
                        "Failed to %s for layered clothing accessory '%s'. Make sure mesh exists and try again.",
                        tbl1[value],
                        arg1.Name
                    )
                )
            else
                tbl7.editableMesh = editableMesh

                table.insert(tbl4, tbl7)
            end
        end
    end

    if #tbl5 > 0 then
        return false, tbl5, nil
    end

    return true, nil, tbl4
end

return getCageMeshInfos
