-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function makeJestCompatible(arg1) -- Luacid: Inlined by compiler; 12 call sites recovered
    return function(_, ...)
        local var1 = arg1(...)

        return {
            pass = var1.pass,
            message = function()
                return var1.message
            end
        }
    end
end

return {
    toBeAbove = makeJestCompatible((require(script.Parent.above))),
    toBeAlignedHorizontally = makeJestCompatible((require(script.Parent.alignedHorizontally))),
    toBeAlignedVertically = makeJestCompatible((require(script.Parent.alignedVertically))),
    toBeBelow = makeJestCompatible((require(script.Parent.below))),
    toBeInside = makeJestCompatible((require(script.Parent.inside))),
    toBeInsideAbove = makeJestCompatible((require(script.Parent.insideAbove))),
    toBeInsideBelow = makeJestCompatible((require(script.Parent.insideBelow))),
    toBeInsideLeftOf = makeJestCompatible((require(script.Parent.insideLeftOf))),
    toBeInsideRightOf = makeJestCompatible((require(script.Parent.insideRightOf))),
    toBeLeftOf = makeJestCompatible((require(script.Parent.leftOf))),
    toBeRightOf = makeJestCompatible((require(script.Parent.rightOf))),
    toIntersect = makeJestCompatible((require(script.Parent.intersect)))
}
