import React, { Component } from 'react';
import {
  Text,
  TouchableHighlight,
  View,
  NavbarButton,
  StyleSheet,
  Image,
  ListView
} from 'react-native';
import StyledNavigationBar from './styledNavigationBar';

export default class ConversationsScreen extends Component {
  constructor() {
    super();
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows(['row 1', 'row 2']),
    };
  }
  
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
          }}
        />
        <ListView
          dataSource={this.state.dataSource}
          renderRow={(rowData) => this.renderCell(rowData)}
          renderSeparator={(sectionID, rowID, adjacentRowHighlighted) => <View style={styles.separator} key={rowID}/>}
        />
      </View>
    );
  }
  
  renderCell(rowData) {
    let topViews = [
      <Text style={styles.username} numberOfLines={1} key='0'>
          {rowData}
      </Text>,
      <Text style={styles.timestamp} numberOfLines={1} key='1'>
        {rowData}
      </Text>
    ];
    let topRow = this.horizontalContainer(topViews, {key: 'top'});
    let bottomViews = [
      <Text style={styles.lastMessage} numberOfLines={2} key='0'>
        wasdin
      </Text>,
      <View style={styles.badgeBackground} key='1'>
        <Text style={styles.badgeText} numberOfLines={1} key='2'>
          1
        </Text>
      </View>
    ];
    let bottomRow = this.horizontalContainer(bottomViews, {key: 'bottom'});
    return (
      <View style={styles.cell}>
        <View style={styles.contentView}>
          {topRow}
          {bottomRow}
        </View>
      </View>
    );
  }

  horizontalContainer(views, ...props) {
    return (
      <View style={styles.horizontalContainer} props>
        {views}
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
  separator: {
    backgroundColor:'black',
    height:1,
  },
  cell: {
    height:93,
  },
  contentView: {
    marginLeft:14,
    marginTop:12,
    marginBottom:20,
    marginRight:14,
  },
  username: {
    flex:1,
    fontSize:17,
    alignSelf:'flex-start',
  },
  timestamp: {
    fontSize:12
  },
  lastMessage: {
    flex:1,
    alignSelf:'flex-start',
    fontSize:10,
  },
  badgeBackground: {
    justifyContent:'center',
    backgroundColor:'black',
    width:24,
    height:24,
    borderRadius:12,
  },
  badgeText: {
    backgroundColor:'transparent',
    color:'white',
    textAlign:'center',
    fontSize:13,
  },
  horizontalContainer: {
    marginTop:8,
    flexDirection:'row',
    alignItems:'stretch',
  }
});