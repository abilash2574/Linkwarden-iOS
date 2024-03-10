//
//  LoginPageView.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import SwiftUI

struct LoginPageView: View {
    
    @ObservedObject var viewState: LoginViewState
    
    @FocusState private var focusedField: LoginViewState.Field?
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [ThemeManager.gradientAStartPoint, ThemeManager.gradientAEndPoint], center: .top, startRadius: -200, endRadius: 1000)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                LinkwardenLogo()
                
                Spacer()
                
                VStack(spacing: 15) {
                    ForEach(viewState.textFieldConfig) { field in
                        LoginTextField(
                            image: field.image,
                            placeholder: field.placeholder,
                            keyboardType: field.keyboardType,
                            contentType: field.contentType,
                            isSecure: field.isSecure,
                            textFieldValue: getBindingValueFor(field: field.focusedField),
                            focused: $focusedField,
                            focusedField: field.focusedField)
                        .padding([.leading, .trailing, .bottom], 8)
                        .onTapGesture {
                            focusedField = field.focusedField
                        }
                    }
                }
                .onSubmit {
                    switch focusedField {
                    case .serverURL:
                        focusedField = .userName
                    case .userName:
                        focusedField = .password
                    case .none:
                        focusedField = .none
                    default:
                        // TODO: ZVZV Most Likely this will the like the user has entered values in all the fields.
                        print("Submit \(viewState.serverURL) - \(viewState.userName) - \(viewState.password)")
                    }
                }
                
                Spacer()
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Button {
                        focusedField = .none
                    } label: {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(minWidth: 180, maxWidth: 300)
                            .foregroundStyle(.themeABackground)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    
                    LoginButtonSeparator()
                    
                    Button {
                        focusedField = .none
                    } label: {
                        Text("Create Account")
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(minWidth: 180, maxWidth: 300)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .stroke(lineWidth: 1.0)
                            )
                    }
                    .controlSize(.regular)
                }
            }
        }
        .onTapGesture {
            focusedField = .none
        }
        .onAppear {
            viewState.viewOnAppearing()
        }
    }
    
    private func getBindingValueFor(field: LoginViewState.Field) -> Binding<String> {
        switch field {
        case .serverURL:
            $viewState.serverURL
        case .userName:
            $viewState.userName
        case .password:
            $viewState.password
        }
    }
}

#Preview {
    LoginAssembler.getLoginPageView()
}


private struct LinkwardenLogo: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(ImageConstants.linkwardenIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Linkwarden")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(ThemeManager.white)
                .aspectRatio(contentMode: .fit)
        }
        .fixedSize()
    }
}

private struct LoginTextField: View {
    
    let image: Image
    let placeholder: String
    
    let keyboardType: UIKeyboardType
    let contentType: UITextContentType
    
    let isSecure: Bool
    
    @Binding var textFieldValue: String
    var focused: FocusState<LoginViewState.Field?>.Binding
    var focusedField: LoginViewState.Field
    
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                    .frame(width: 30, height: 30)
                if isSecure {
                    SecureField(
                        "",
                        text: $textFieldValue,
                        prompt:
                            Text(placeholder)
                            .foregroundColor(ThemeManager.label))
                    .modifier(LoginTextFieldModifier(keyboardType: keyboardType, contentType: contentType, focused: focused, focusedField: focusedField))
                } else {
                    TextField(
                        "",
                        text: $textFieldValue,
                        prompt:
                            Text(placeholder)
                            .foregroundColor(ThemeManager.label))
                    .modifier(LoginTextFieldModifier(keyboardType: keyboardType, contentType: contentType, focused: focused, focusedField: focusedField))
                }
            }
            .padding(8)
            .background(ThemeManager.secondaryBackground)
            .clipShape(.rect(cornerRadius: 15))
            Spacer()
        }
    }
}

private struct LoginButtonSeparator: View {
    var body: some View {
        HStack {
            Spacer()
            Rectangle()
                .foregroundStyle(ThemeManager.white)
                .frame(width: 100, height: 0.5)
            Text("OR")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(ThemeManager.white)
            Rectangle()
                .foregroundStyle(ThemeManager.white)
                .frame(width: 100, height: 0.5)
            Spacer()
        }
    }
}

private struct LoginTextFieldModifier: ViewModifier {
    
    let keyboardType: UIKeyboardType
    let contentType: UITextContentType
    
    var focused: FocusState<LoginViewState.Field?>.Binding
    var focusedField: LoginViewState.Field
    
    func body(content: Content) -> some View {
        content
            .focused(focused, equals: focusedField)
            .keyboardType(keyboardType)
            .textContentType(contentType)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .font(.body)
            .frame(maxWidth: 300)
    }
}
