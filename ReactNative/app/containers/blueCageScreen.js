import React, { Component } from 'react';
import {
    Navigator,
} from 'react-native';
import welcomeScreen from './welcomeScreen';

const routes = [
    {component: welcomeScreen, title: 'First Scene', index: 0},
];

export default class BlueCage extends Component {
  render() {
    return (
      <Navigator
          initialRouteStack={routes}
          initialRoute={routes[0]}
          renderScene={(route, navigator) => (
            <route.component navigator={navigator}/>
          )
        }
      />
    );
  }
};
