import React from 'react';
import NavigationBar from 'react-native-navbar';

const StyledNavigationBar = ({...props}) => (
	<NavigationBar
	statusBar={{tintColor:'black', style:'light-content'}}
	style={{
      backgroundColor:'black',
    }}
	{...props}/>
);

export default StyledNavigationBar;