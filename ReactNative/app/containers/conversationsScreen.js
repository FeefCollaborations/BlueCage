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
      dataSource: ds.cloneWithRows(this.fakeData()),
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
  
  fakeData() {
    return [
      {
        recipient: {
          id: 0,
          name: 'recipient name 0',
        },
        id: 0,
        messages: [
        ],
        lastSeenMessageDate: new Date(100),
      },
      {
        recipient: {
          id: 1,
          name: 'recipient name 1',
        },
        id: 1,
        messages: [
          {
            id: 0,
            text: 'text 0',
            timestamp: new Date(100),
          },
          {
            id: 1,
            text: 'text 1',
            timestamp: new Date(10000),
          },
        ],
        lastSeenMessageDate: new Date(100),
      }
    ];
  }
  
  renderCell(rowData) {
    var topViews = [
      <Text style={styles.username} numberOfLines={1} key='0'>
        {rowData.recipient.name}
      </Text>
    ];
    let lastMessage = rowData.messages[rowData.messages.length - 1];
    if (lastMessage !== undefined) {
      let dateString = lastMessage.timestamp.toLocaleDateString() + ' ' + lastMessage.timestamp.toLocaleTimeString();
      topViews.push(
        <Text style={styles.timestamp} numberOfLines={1} key='1'>
          {dateString}
        </Text>
      );
    }
    let topRow = this.horizontalContainer(topViews, {key: 'top'});
    
    let lastMessageText = lastMessage !== undefined ? lastMessage.text : 'Start the conversation!';
    var bottomViews = [
      <Text style={styles.lastMessage} numberOfLines={2} key='0'>
        {lastMessageText}
      </Text>
    ];
    let unseenMessagesString = this.unseenMessagesString(rowData);
    if (unseenMessagesString !== undefined) {
      bottomViews.push(
        <View style={styles.badgeBackground} key='1'>
          <Text style={styles.badgeText} numberOfLines={1} key='2'>
            {unseenMessagesString}
          </Text>
        </View>
      );
    }
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

  unseenMessagesString(conversation) {
    var unseenCount = 0;
    for(i=conversation.messages.length-1; i>=0; i--) {
      let message = conversation.messages[i];
      if (message.timestamp.getTime() <= conversation.lastSeenMessageDate.getTime()) {
        break;
      }
      console.log(conversation.lastSeenMessageDate.getTime + ' , ' + message.timestamp.getTime);
      unseenCount++;
      if (unseenCount >= 10) {
        return '9+';
      }
    }
    return unseenCount==0 ? undefined : unseenCount;
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