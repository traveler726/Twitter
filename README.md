# Project 3 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com).

Time spent: **35** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow.
- [x] User can view last 20 tweets from their home timeline.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Profile page
   - [x] Contains the user header view (implemented as a custom view)
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline
   - [x] Tapping on a user image should bring up that user's profile page
- [x] Tab Navigational
   - [x] The menu should include links to your profile, the home timeline.

The following **optional** features are implemented:

- [x] Persisted User Login State across app restarts.
- [x] Logout and Re-Login capability with saved state
- [x] Profile Updates each time switching to the Profile page.
- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] Pulling down the profile page should blur and resize the header image.
- [x] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account
- [ ] Hamburger menu
   - [ ] Dragging anywhere in the view should reveal the menu.
   - [ ] The menu should include links to your profile, the home timeline, and the mentions view.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
   * Lots of opportunity for refactoring and improving the structure of the code.
      * DataModel Cleaup
      * Control/Services Model Cleanup
   * Lots of opportunity for UI sharpening.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/traveler726/Twitter/blob/master/VideoWalkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

It was often hard to see the path for getting any given task completed.  
The overall architecture of how you want to setup a project and the was not part of the project/class setup and had to be pull from the Yahoo! folks that were helping.  Granted they were extremely helpful - but would have been much easier to have the up-front pictures to view and work through PRIOR to trying to do the projects.


## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
