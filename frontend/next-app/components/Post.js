import { useState } from 'react';
import { toast } from 'react-toastify';
import { usePostsStore } from '../stores/postsStore';
import { useUserStore } from '../stores/userStore';
import { makePostRequest } from '../utils/requests';

export default function Post({ post, upvotes = [], comments = [] }) {
    const [edit, setEdit] = useState(false);
    const userId = useUserStore((state) => state.user.id);
    const updateUpvotes = usePostsStore((state) => state.updateUpvotes);
    const updatePost = usePostsStore((state) => state.updatePost);
    const removePost = usePostsStore((state) => state.removePost);
    const [curPost, setCurPost] = useState({
        id: post.id,
        title: post.title,
        content: post.content,
    });

    const handleUpVote = async () => {
        const resData = makePostRequest(
            `http://localhost:5000/posts/upvote`,
            { user_id: userId, post_id: post.id },
            (resData) => {
                updateUpvotes(post.id, resData.data.upvotes);
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    const handleEdit = async () => {
        if (edit) {
            const resData = makePostRequest(
                `http://localhost:5000/posts/update`,
                { ...curPost, user_id: userId },
                (resData) => {
                    console.log(resData);
                    updatePost(resData.data.id, resData.data);
                },
                (resData) => {
                    toast(resData.message, { type: 'error' });
                }
            );
        }
        setEdit((p) => !p);
    };

    const handleDelete = async () => {
        const resData = makePostRequest(
            `http://localhost:5000/posts/delete`,
            { post_id: post.id, user_id: userId },
            (resData) => {
                console.log(resData);
                removePost(resData.data.post_id);
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    const handleChange = (e) => {
        setCurPost((prev) => {
            return { ...prev, [e.target.name]: e.target.value };
        });
    };

    return (
        <div class='post__container'>
            <div class='post__top'>
                {post.user_id == userId ? (
                    <div className='post__actions'>
                        <button onClick={handleEdit}>
                            {edit ? 'Save' : 'Edit'}
                        </button>
                        <button onClick={handleDelete}>Delete</button>
                    </div>
                ) : (
                    <></>
                )}
                <p class='post__title'>
                    ({post.username}){' '}
                    {edit ? (
                        <>
                            <input
                                value={curPost.title}
                                name='title'
                                onChange={handleChange}
                            />
                        </>
                    ) : (
                        post.title
                    )}
                </p>
                <p class='post__content'>
                    {edit ? (
                        <>
                            <input
                                value={curPost.content}
                                name='content'
                                onChange={handleChange}
                            />
                        </>
                    ) : (
                        curPost.content
                    )}
                </p>
            </div>
            <div class='post__bottom'>
                <button class='post__upvote' onClick={handleUpVote}>
                    Upvote ({post.upvotes})
                </button>
                <div class='post__comment'>Comment ({comments.length})</div>
            </div>
        </div>
    );
}
