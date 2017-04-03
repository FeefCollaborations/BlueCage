import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    StyleSheet,
} from 'react-native';
import NavigationBar from 'react-native-navbar';

export default class SignUpScreen extends Component {
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
      </View>
    );
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
});

AppRegistry.registerComponent('SignUpScreen', () => SignUpScreen);
