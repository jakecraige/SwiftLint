//
//  FileLengthRule.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-05-16.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import SourceKittenFramework

public struct FileLengthRule: ParameterizedRule {
    public init() {
        self.init(parameters: [
            RuleParameter(severity: .VeryLow, value: 400),
            RuleParameter(severity: .Low, value: 500),
            RuleParameter(severity: .Medium, value: 750),
            RuleParameter(severity: .High, value: 1000),
            RuleParameter(severity: .VeryHigh, value: 2000)
        ])
    }

    public init(parameters: [RuleParameter<Int>]) {
        self.parameters = parameters
    }

    public let identifier = "file_length"

    public let parameters: [RuleParameter<Int>]

    public func validateFile(file: File) -> [StyleViolation] {
        let lines = file.contents.lines()
        for parameter in parameters.reverse() {
            if lines.count > parameter.value {
                return [StyleViolation(type: .Length,
                    location: Location(file: file.path, line: lines.count),
                    severity: parameter.severity,
                    reason: "File should contain \(parameters.first!.value) lines or less: " +
                    "currently contains \(lines.count)")]
            }
        }
        return []
    }

    public let example = RuleExample(
        ruleName: "File Line Length Rule",
        ruleDescription: "Files should be less than 400 lines.",
        nonTriggeringExamples: [],
        triggeringExamples: [],
        showExamples: false
    )
}
