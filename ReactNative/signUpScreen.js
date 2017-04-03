import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    StyleSheet,
    TextInput,
    TouchableHighlight,
    Text,
    Keyboard,
    Dimensions,
    LayoutAnimation,
} from 'react-native';
import NavigationBar from 'react-native-navbar';

const constants = {
  emailPlaceholderText: 'Email',
  passwordPlaceholderText: 'Email',
}

export default class SignUpScreen extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentNameText: '',
      currentEmailText: '',
      currentPasswordText: '',
      containerBottomInset: 0,
    };
  }

  componentWillMount() {
    Keyboard.addListener('keyboardWillShow', ((keyboard) => this.expandContainer(false, keyboard)));
    Keyboard.addListener('keyboardWillHide', ((keyboard) => this.expandContainer(true, keyboard)));
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
              title: 'Sign Up',
              tintColor: 'white',
          }}
          leftButton= {{
              title: 'Back',
              handler: () => this.props.navigator.pop(),
        }}/>
        <View style={styles.interactiveViewsContainer} bottom={this.state.containerBottomInset}>
          <TextInput
            style={[styles.textArea, styles.textAreaContainer]}
            placeholder='Name'
          onChangeText={(text) => { this.updateNameText(text) }}/>
          <TextInput
            style={[styles.textArea, styles.textAreaContainer]}
            placeholder='Email'
          onChangeText={(text) => { this.updateEmailText(text) }}/>
          <TextInput
            style={[styles.textArea, styles.textAreaContainer]}
            placeholder='Password'
          onChangeText={(text) => { this.updatePasswordText(text) }}/>
          <TouchableHighlight style={styles.textAreaContainer} underlayColor='transparent' onPress={this.attemptLogin}>
            <Text style={styles.textArea}>Sign Up</Text>
          </TouchableHighlight>
        </View>
      </View>
    );
  }

  expandContainer(expand, keyboard) {
    LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
    var state = this.state;
    state.containerBottomInset = expand ? 0 : keyboard.endCoordinates.height / 2;
    this.setState(state);
  }

  attemptLogin() {
    // TODO: Show "loading" alert, send off network request to validate account info, and respond to response appropriately
  }

  updateNameText(text) {
    var state = this.state;
    state.currentNameText = text;
    this.setState(state);
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
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
      flexDirection:'column',
      backgroundColor:'white',
    },
    interactiveViewsContainer: {
      flex:1,
      flexDirection:'column',
      justifyContent:'center',
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

AppRegistry.registerComponent('SignUpScreen', () => SignUpScreen);
