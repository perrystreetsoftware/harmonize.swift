//
//  AttributeListSyntax+AttributesProviding.swift
//
//
//  Created by Lucas Cavalcante on 8/24/24.
//

import Foundation
import SwiftSyntax

extension AttributeListSyntax: AttributesProviding {
    public var attributes: [Attribute] {
        compactMap {
            return switch $0 {
            case .attribute(let attributeNode):
                attributeNode.attribute
            default:
                nil
            }
        }
    }
}

extension AttributeSyntax {
    var attribute: Attribute? {
        Attribute.from(
            attributeName: attributeName.trimmedDescription,
            arguments: arguments(from: arguments)
        )
    }
    
    private func arguments(from args: AttributeSyntax.Arguments?) -> [String] {
        guard let args else { return [] }
        
        return switch args {
        case .argumentList(let values):
            values.map { "\($0)" }
        case .token(let value):
            [value.text]
        case .string(let value):
            [value.trimmedDescription]
        case .availability(let values):
            values.compactMap {
                return if let comma = $0.trailingComma?.text {
                    $0.trimmedDescription.replacingOccurrences(of: comma, with: "")
                } else {
                    availability(from: $0.argument)
                }
            }
        case .specializeArguments(let values):
            values.map { "\($0)" }
        case .objCName(let values):
            values.map { $0.trimmedDescription }
        case .implementsArguments(let value):
            [value.type.trimmedDescription]
        case .differentiableArguments(let value):
            [value.arguments?.arguments.trimmedDescription].compactMap { $0 }
        case .derivativeRegistrationArguments(let value):
            [value.trimmedDescription]
        case .backDeployedArguments(let value):
            value.platforms.map { $0.platformVersion.description }
        case .conventionArguments(let value):
            ["(\(value.conventionLabel.text))"]
        case .conventionWitnessMethodArguments(let value):
            [value.protocolName.text]
        case .opaqueReturnTypeOfAttributeArguments(let value):
            [value.mangledName.trimmedDescription]
        case .exposeAttributeArguments(let value):
            [value.trimmedDescription]
        case .originallyDefinedInArguments(let value):
            [value.trimmedDescription]
        case .underscorePrivateAttributeArguments(let value):
            [value.sourceFileLabel.text]
        case .dynamicReplacementArguments(let value):
            [value.declName.trimmedDescription]
        case .unavailableFromAsyncArguments(_):
            []
        case .effectsArguments(let values):
            values.map { $0.text }
        case .documentationArguments(let values):
            values.map { $0.label.text }
        @unknown default:
            []
        }
    }
    
    private func availability(from arg: AvailabilityArgumentSyntax.Argument) -> String? {
        return switch arg {
        case .token(let token):
            token.text
        case .availabilityVersionRestriction(let versionRestriction):
            if let version = versionRestriction.version {
                "\(versionRestriction.platform.text) \(version)"
            } else {
                versionRestriction.platform.text
            }
        case .availabilityLabeledArgument(let labeledArgument):
            availabilityLabeledArgument(from: labeledArgument)
        default:
            nil
        }
    }
    
    private func availabilityLabeledArgument(from arg: AvailabilityLabeledArgumentSyntax) -> String? {
        let value: String? = switch arg.value {
        case .string(let literalStringExpression):
            literalStringExpression.segments.trimmedDescription
        case .version(let versionTuple):
            versionTuple.trimmedDescription
        default:
            nil
        }
        
        return if let value = value {
            "\(arg.label.text): \(value)"
        } else {
            arg.label.text
        }
    }
}
