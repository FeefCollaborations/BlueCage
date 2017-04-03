import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    StyleSheet,
    TextInput,
    TouchableHighlight,
    Text,
    Keyboard,
    DeviceEventEmitter
} from 'react-native';
import NavigationBar from 'react-native-navbar';

const constants = {
  emailPlaceholderText: 'Email',
  passwordPlaceholderText: 'Email',
}

export default class LoginScreen extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentEmailText: '',
      currentPasswordText: '',
    };
  }

  componentWillMount() {
    this.keyboardWillShowListener = Keyboard.addListener('keyboardWillShow', this.updateTextFieldContainer.bind(this));
    this.keyboardWillHideListener = Keyboard.addListener('keyboardWillHide', this.updateTextFieldContainer.bind(this));
  }

  componentWillUnmount() {
    this.keyboardDidShowListener.remove()
    this.keyboardDidHideListener.remove()
  }

  render() {
    return (
      <View style={styles.rootView}>
        <NavigationBar
          statusBar={{
            tintColor:'black',
            style:'light-content',
          }}
          style={styles.navbarStyle}
          title= {{
              title: 'Log In',
              tintColor: 'white',
          }}
          leftButton= {{
              title: 'Back',
              handler: () => this.props.navigator.pop(),
        }}/>
        <View style={styles.textFieldContainer}>
          <TextInput
            style={styles.textField}
            placeholder='Email'
          onChangeText={(text) => { this.updateEmailText(text) }}/>
          <TextInput
            style={styles.textField}
            placeholder='Password'
          onChangeText={(text) => { this.updatePasswordText(text) }}/>
        </View>
      </View>
    );
  }

  updateEmailText(text) {
    var state = this.state;
    state.currentEmailText = text;
    this.setState(state);
  }

  updatePasswordText(text) {
    var state = this.state;
    state.currentPasswordText = text;
    this.setState(state);
  }

  updateTextFieldContainer() {
    console.log('yes');
  }
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
      flexDirection:'column',
      backgroundColor:'white',
    },
    textFieldContainer: {
      flex:1,
      flexDirection:'column',
      justifyContent:'center',
    },
    navbarStyle: {
      backgroundColor:'black',
    },
    textField: {
      height: 30,
      textAlign: 'center',
    },
});


AppRegistry.registerComponent('LoginScreen', () => LoginScreen);
