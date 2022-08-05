import 'package:auxilium/post%20viewers/post_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final postsRef = FirebaseFirestore.instance.collection('Posts');
final usersRef = FirebaseFirestore.instance.collection('Users');

class RetrievePost {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  // PLACEHOLDER ID, NEED TO RETRIEVE FROM FIREBASE
  final String postId = '123';
  final String dp;
  final String username;

  const RetrievePost(this.user, this.googleSignIn, this.dp, this.username);

/* Need to create 3 different post caches: 
(1) Community Feed -> ALL posts from db, SORTED by latest to oldest TIME
(2) My Account (donating) Feed -> ONLY USER donating posts, sorted by latest to oldest TIME
(3) My Account (Receiving) Feed -> ONLY USER RECEIVING posts, sorted by latest to oldest TIME */

// Placeholder Post Caches
  List<Post> loadCommunityPostCache() {
    // INSERT DB QUERIES HERE
    return [
      const Post(
        postId: '0000',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Community Post Cache',
        timeAgo: '1m',
        text:
            'This is a community feed post. It can be both a requesting or donating post.',
        title: 'Community Feed Post',
        comments: '0',
      ),
      const Post(
        postId: '0001',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Maria',
        timeAgo: '5m',
        text: 'Free English tuition! Teaching P3-P6.',
        title: 'Primary School Tuition',
        comments: '243',
      ),
      const Post(
        postId: '0002',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Jameson',
        timeAgo: '12m',
        text: 'Thank you for meeting my request yesterday!',
        title: 'Grateful',
        comments: '46',
      ),
      const Post(
        postId: '0002',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Andrea',
        timeAgo: '20m',
        text:
            'Leftover chicken pie from yesterday\'s dinner, fully untouched and really good! Come by, all invited.',
        title: 'Chicken Pie',
        comments: '305',
      ),
      const Post(
        postId: '0003',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Linda',
        timeAgo: '21m',
        text:
            'Need babysitter to help with taking care of 5 y.o. as I go to work tomorrow',
        title: 'Babysitter',
        comments: '1K',
      ),
      const Post(
        postId: '0004',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Marcus',
        timeAgo: '26m',
        text: 'Looking for workspace to study for my PSLE',
        title: 'Study Space',
        comments: '10K',
      ),
      const Post(
        postId: '0005',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Yolanda',
        timeAgo: '40m',
        text: 'Need a new washing machine! Anyone have contacts?',
        title: 'Washing Machine',
        comments: '10',
      ),
      const Post(
        postId: '0006',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Trisha',
        timeAgo: '1h',
        text: 'donating out a free airfryer',
        title: 'Airfryer',
        comments: '1K',
      ),
    ];
  }

// REQUESTING
  List<Post> loadRequestingAccPostCache() {
    // INSERT DB QUERIES HERE
    return [
      const Post(
        postId: '0000',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Requesting Post Cache',
        timeAgo: '1m',
        text:
            'This is an account post. It is a requesting post as the tab selected is \'Requesting\'.',
        title: 'Account Requesting Post',
        comments: '0',
      ),
    ];
  }

// donating
  List<Post> loadDonatingAccPostCache() {
    // INSERT DB QUERIES HERE
    return [
      const Post(
        postId: '0000',
        dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
        username: 'Donating Post Cache',
        timeAgo: '1m',
        text:
            'This is an account post. It is a requesting post as the tab selected is \'donating\'.',
        title: 'Account Donating Post',
        comments: '0',
      ),
    ];
  }
}
