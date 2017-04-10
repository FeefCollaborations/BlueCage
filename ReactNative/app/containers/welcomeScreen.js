import React, { Component } from 'react';
import {
    AppRegistry,
    Text,
    TouchableHighlight,
    View,
    NavbarButton,
    StyleSheet,
    Image
} from 'react-native';
import signUpScreen from './signUpScreen';
import loginScreen from './loginScreen';
import NavigationBar from 'react-native-navbar';

const Constants = {
  buttonOuterMargin: 51,
  buttonInnerMargin: 44,
  blueCageIcon: require('../resources/BlueCageLogo.png'),
}

export default class WelcomeScreen extends Component {

  render() {
    return (
      <View style={styles.rootView}>
        <NavigationBar
          statusBar={{
            tintColor:'white',
            style:'default',
        }}/>
        <View style={styles.imageContainer}>
          <Image source={Constants.blueCageIcon}/>
        </View>
        <TouchableHighlight
          style={[styles.button, styles.topButton]}
          onPress={() => this.onPress(signUpScreen)}>
          <Text style={styles.text}>Sign Up</Text>
        </TouchableHighlight>
        <TouchableHighlight
          style={[styles.button, styles.bottomButton]}
          onPress={() => this.onPress(loginScreen)}>
          <Text style={styles.text}>Log In</Text>
        </TouchableHighlight>
      </View>
    );
  }

  onPress(component) {
    this.props.navigator.push({
      component: component
    });
  }
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
      flexDirection:'column',
    },
    text: {
      textAlign:'center',
      color:'white',
    },
    topButton: {
      marginBottom: Constants.buttonInnerMargin,
    },
    bottomButton: {
      marginBottom: Constants.buttonOuterMargin
    },
    button: {
      justifyContent:'center',
      backgroundColor:'black',
      height:56,
    },
    imageContainer: {
      flex:1,
      justifyContent:'center',
      alignItems:'center',
    }
});