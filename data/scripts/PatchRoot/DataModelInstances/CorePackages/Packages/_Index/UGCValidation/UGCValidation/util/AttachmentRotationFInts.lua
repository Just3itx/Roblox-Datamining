-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("UGCValidationAttRotRigAttachmentMaxThousandthsDegrees", 10)
game:DefineFastInt("UGCValidationAttRotLimitRootAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitFaceFrontAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitHatAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitHairAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitFaceCenterAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitRightFootAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitLeftFootAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitBodyFrontAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitBodyBackAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitLeftCollarAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitRightCollarAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitNeckAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitWaistCenterAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitWaistFrontAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitWaistBackAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitLeftShoulderAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitLeftGripAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitRightShoulderAttachment", 30)
game:DefineFastInt("UGCValidationAttRotLimitRightGripAttachment", 30)

return {
    thresholdGetters = {
        RigAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotRigAttachmentMaxThousandthsDegrees") / 1000
        end,
        RootAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitRootAttachment")
        end,
        FaceFrontAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitFaceFrontAttachment")
        end,
        HatAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitHatAttachment")
        end,
        HairAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitHairAttachment")
        end,
        FaceCenterAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitFaceCenterAttachment")
        end,
        RightFootAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitRightFootAttachment")
        end,
        LeftFootAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitLeftFootAttachment")
        end,
        BodyFrontAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitBodyFrontAttachment")
        end,
        BodyBackAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitBodyBackAttachment")
        end,
        LeftCollarAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitLeftCollarAttachment")
        end,
        RightCollarAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitRightCollarAttachment")
        end,
        NeckAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitNeckAttachment")
        end,
        WaistCenterAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitWaistCenterAttachment")
        end,
        WaistFrontAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitWaistFrontAttachment")
        end,
        WaistBackAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitWaistBackAttachment")
        end,
        LeftShoulderAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitLeftShoulderAttachment")
        end,
        LeftGripAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitLeftGripAttachment")
        end,
        RightShoulderAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitRightShoulderAttachment")
        end,
        RightGripAttachment = function(): number
            return game:GetFastInt("UGCValidationAttRotLimitRightGripAttachment")
        end
    }
}
