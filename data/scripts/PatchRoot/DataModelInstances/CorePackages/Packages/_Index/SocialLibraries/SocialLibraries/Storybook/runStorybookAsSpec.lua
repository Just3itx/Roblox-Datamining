-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, callback, callback2)
    local storyRoots = arg1.storyRoots
    local mapStory = arg1.mapStory

    callback("SHOULD run all stories with no issue", function()
        for _, storyRoot in ipairs(storyRoots) do
            for _, descendant in ipairs(storyRoot:GetDescendants()) do
                if not (descendant:IsA("ModuleScript") and descendant.Name:find(".story$")) then
                    continue
                end

                callback2("SHOULD mount: " .. descendant:GetFullName(), function(arg2)
                    local var1 = require(descendant)
                    local var2 = mapStory(function()
                        return var1
                    end)()

                    local _, var3 = arg2.UnitTestHelpers.mountFrame(var2)

                    var3()
                end)
            end
        end
    end)
end
