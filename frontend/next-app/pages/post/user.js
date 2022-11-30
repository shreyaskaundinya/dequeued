import { useRouter } from 'next/router';
import { toast } from 'react-toastify';
import { useUserStore } from '../../stores/userStore';
import getFormData from '../../utils/getFormData';
import { makePostRequest } from '../../utils/requests';

export default function Create() {
    const user = useUserStore((state) => state.user);
    const router = useRouter();

    const handlePostUpdate = async (e) => {
        e.preventDefault();
        const data = getFormData(e.target);
        console.log({ user_id: user.id, post: data });
        const resData = await makePostRequest(
            'http://localhost:5000/posts/create',
            { user_id: user.id, post: data },
            (resData) => {
                toast('Added post successfully!');
                router.push('/');
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    const handlePostDelete = async (e) => {
        e.preventDefault();
        const data = getFormData(e.target);
        console.log({ user_id: user.id, post: data });
        const resData = await makePostRequest(
            'http://localhost:5000/posts/create',
            { user_id: user.id, post: data },
            (resData) => {
                toast('Added post successfully!');
                router.push('/');
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    return (
        <div className='page'>
            <h1>Create Post</h1>
            <form class='post-form' onSubmit={handlePostCreate}>
                <label>
                    Title
                    <input name='title' />
                </label>
                <label>
                    Content
                    <textarea name='content' />
                </label>
                <button>Add</button>
            </form>
        </div>
    );
}
