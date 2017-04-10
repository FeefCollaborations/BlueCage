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
import NavigationBar from 'react-native-navbar';
import StyledNavigationBar from './styledNavigationBar';

export default class ConversationsScreen extends Component {
  render() {
    return (
      <View style={styles.rootView}>
        <StyledNavigationBar
          title={{
              title: 'Conversations',
              tintColor: 'white',
          }}
          leftButton={{
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
    },
});