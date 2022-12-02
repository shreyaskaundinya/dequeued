import { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import Post from '../components/Post';
import { getPosts, usePostsStore } from '../stores/postsStore';
import { useUserStore } from '../stores/userStore.js';

export default function Home() {
    const user = useUserStore((state) => state.user);
    const [homePosts, setHomePosts] = useState([]);
    const setPosts = usePostsStore((state) => state.setPosts);
    const unsubacabarise = usePostsStore.subscribe((state, prevState) => {
        setHomePosts(state.posts);
    });

    const getNewPosts = async () => {
        const [data, error] = await getPosts(user);
        if (error) {
            toast(error, { type: 'error' });
        } else {
            setPosts(data);
        }
        console.log(data);
    };

    useEffect(() => {
        getNewPosts();
    }, [user]);

    useEffect(() => {
        return () => {
            unsubacabarise();
        };
    }, []);

    return (
        <div className='page'>
            <p>HELLO WORLD, {user.username}</p>
            <button className='btn btn-blue' onClick={getNewPosts}>
                Refresh
            </button>
            {homePosts?.map((p) => {
                return <Post post={p} key={p.id} upvotes={[]} comments={[]} />;
            })}
        </div>
    );
}
