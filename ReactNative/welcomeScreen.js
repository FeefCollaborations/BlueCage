import React, { Component } from 'react';
import {
    AppRegistry,
    Text,
    Button,
    View,
    NavbarButton,
    StyleSheet
} from 'react-native';

export default class WelcomeScreen extends Component {
  render() {
    return (
      <View style={styles.rootView}>
        <View style={styles.container}>
          <Button style={styles.button} title='yeahhhh'onPress={this.onPress}></Button>
          <Button style={styles.button} title='yeahhhh'onPress={this.onPress}></Button>
        </View>
      </View>
    );
  }

  onPress() {
  
  }
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
    },
    container: {
      flex:1,
      flexDirection:'column-reverse',
      height:100,
    },
    button: {
      height:100,
      marginBottom: 1000,
    },
});

AppRegistry.registerComponent('WelcomeScreen', () => WelcomeScreen);
