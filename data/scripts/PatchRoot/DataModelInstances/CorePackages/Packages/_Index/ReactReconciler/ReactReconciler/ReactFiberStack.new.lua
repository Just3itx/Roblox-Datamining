-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local tbl1 = {}

local tbl2 = ({})

local var1 = nil

var1 = ReactGlobals.__DEV__ and {} or var1

local num1 = 0

return {
    createCursor = function(current)
        return { current = current }
    end,
    isEmpty = function(): boolean
        return num1 == 0
    end,
    pop = function(tbl3, arg1)
        if num1 < 1 then
            if ReactGlobals.__DEV__ then
                console.error("Unexpected pop.")
            end
            return
        end

        if ReactGlobals.__DEV__ and arg1 ~= var1[num1] then
            console.error("Unexpected Fiber popped.")
        end

        local current = tbl2[num1]
        if current == tbl1 then
            tbl3.current = nil
        else
            tbl3.current = current
        end

        tbl2[num1] = nil

        if ReactGlobals.__DEV__ then
            var1[num1] = nil
        end

        num1 -= 1
    end,
    push = function(tbl3, current, arg1)
        num1 += 1

        local current2 = tbl3.current
        if current2 == nil then
            tbl2[num1] = tbl1
        else
            tbl2[num1] = current2
        end

        if ReactGlobals.__DEV__ then
            var1[num1] = arg1
        end

        tbl3.current = current
    end,
    checkThatStackIsEmpty = function()
        if ReactGlobals.__DEV__ and num1 ~= 0 then
            console.error("Expected an empty stack. Something was not reset properly.")
        end
    end,
    resetStackAfterFatalErrorInDev = function()
        if ReactGlobals.__DEV__ then
            num1 = 0

            table.clear(tbl2)
            table.clear(var1)
        end
    end
}
