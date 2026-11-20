-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local createGroupMotor = require(script.createGroupMotor)
local createSingleMotor = require(script.createSingleMotor)
local ease = require(script.ease)
local spring = require(script.spring)
local instant = require(script.instant)
local _types = require(script.types)

return {
    createGroupMotor = createGroupMotor,
    createSingleMotor = createSingleMotor,
    ease = ease,
    spring = spring,
    instant = instant,
    __devAnimationStepSignal = require(script.AnimationStepSignal)
}
