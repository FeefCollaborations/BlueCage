import React, { Component } from 'react';
import {
    View,
    StyleSheet,
    TextInput,
    TouchableHighlight,
    Text,
    Keyboard,
    Dimensions,
    LayoutAnimation,
} from 'react-native';
import KeyboardReactiveView from './keyboardReactiveView';
import conversationsScreen from './conversationsScreen';
import StyledNavigationBar from './styledNavigationBar';

const constants = {
  namePlaceholderText: 'Name',
  emailPlaceholderText: 'Email',
  passwordPlaceholderText: 'Password',
}

export default class SignUpScreen extends Component {
  render() {
    let interactiveViews = this.interactiveViews();
    return (
      <View style={styles.rootView}>
        <StyledNavigationBar
          title={{
              title: 'Sign Up',
              tintColor: 'white',
          }}
          leftButton={{
              title: 'Back',
              handler: () => this.props.navigator.pop(),
          }}
        />
        <KeyboardReactiveView views={interactiveViews}/>
      </View>
    );
  }

  interactiveViews() {
    return [
      <TextInput
        key={constants.namePlaceholderText}
        style={[styles.textArea, styles.textAreaContainer]}
        placeholder={constants.namePlaceholderText}
        onChangeText={(text) => { this.updateNameText(text) }}/>,
      <TextInput
        key={constants.emailPlaceholderText}
        style={[styles.textArea, styles.textAreaContainer]}
        placeholder={constants.emailPlaceholderText}
        onChangeText={(text) => { this.updateEmailText(text) }}/>,
      <TextInput
        key={constants.passwordPlaceholderText}
        style={[styles.textArea, styles.textAreaContainer]}
        placeholder={constants.passwordPlaceholderText}
        onChangeText={(text) => { this.updatePasswordText(text) }}/>,
      <TouchableHighlight key='button' style={styles.textAreaContainer} underlayColor='transparent' onPress={()=>this.attemptLogin()}>
        <Text key='buttonText' style={styles.textArea}>Sign Up</Text>
      </TouchableHighlight>,
    ];
  }

  attemptLogin() {
    // TODO: Show "loading" alert, send off network request to validate account info, and respond to response appropriately
    this.props.navigator.push({
      component: conversationsScreen,
    });
  }

  updateNameText(text) {
    this.currentNameText = text;
  }

  updateEmailText(text) {
    this.currentEmailText = text;
  }

  updatePasswordText(text) {
    this.currentPasswordText = text;
  }
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
      flexDirection:'column',
      backgroundColor:'white',
    },
    navbarStyle: {
      backgroundColor:'black',
    },
    textArea: {
      height: 30,
      textAlign: 'center',
    },
    textAreaContainer: {
      marginVertical: 20,
    }
});
