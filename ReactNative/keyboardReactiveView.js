import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    StyleSheet,
    Keyboard,
    Dimensions,
    LayoutAnimation,
} from 'react-native';
import NavigationBar from 'react-native-navbar';

export default class KeyboardReactiveView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      containerBottomInset: 0,
    };
  }

  componentWillMount() {
    this.keyboardShowListener = Keyboard.addListener('keyboardWillShow', ((keyboard) => this.expandContainer(false, keyboard)));
    this.keyboardHideListener = Keyboard.addListener('keyboardWillHide', ((keyboard) => this.expandContainer(true, keyboard)));
  }

  componentWillUnmount() {
    this.keyboardShowListener.remove();
    this.keyboardHideListener.remove();
  }

  render() {
    return (
      <View style={styles.rootView} bottom={this.state.containerBottomInset}>
        {this.props.views}
      </View>
    );
  }

  expandContainer(expand, keyboard) {
    LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
    var state = this.state;
    state.containerBottomInset = expand ? 0 : keyboard.endCoordinates.height / 2;
    this.setState(state);
  }
};

const styles = StyleSheet.create({
    rootView: {
      flex:1,
      flexDirection:'column',
      justifyContent:'center',
    }
});

AppRegistry.registerComponent('KeyboardReactiveView', () => KeyboardReactiveView);
