import { useState } from 'react';
import { toast } from 'react-toastify';
import { makePostRequest } from '../../utils/requests';

export default function Custom() {
    const [results, setResults] = useState([]);
    const [headers, setHeaders] = useState([]);
    const [query, setQuery] = useState('');

    const handleChange = (e) => {
        setQuery(() => e.target.value);
    };

    const handleGetResults = () => {
        const resData = makePostRequest(
            `http://localhost:5000/custom`,
            { query: query },
            (resData) => {
                if (resData?.data?.results) {
                    setResults(resData.data.results);
                }
                if (resData?.data?.headers) {
                    setHeaders(resData.data.headers);
                }
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    return (
        <div className='page'>
            <p className='text-xl font-bold mt-7'>Custom query</p>

            <label className='mt-8'>
                Write the query :
                <textarea name='text' onChange={handleChange} />
            </label>

            <button className='mt-6' onClick={handleGetResults}>
                Get Results
            </button>

            <div className='mt-8'>
                <p className='font-bold mb-5'>RESULTS : </p>
                <table className='overflow-x-scroll'>
                    <thead>
                        {headers.map((h) => (
                            <th key={h} className='border border-black p-2'>
                                {h}
                            </th>
                        ))}
                    </thead>
                    <tbody>
                        {results.map((r) => {
                            return (
                                <tr className='border border-black p-2'>
                                    {r.map((c) => (
                                        <td className='border border-black p-2'>
                                            {c}
                                        </td>
                                    ))}
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
                <div className='mb-4 mt-8'>
                    <p className='font-bold'>Result JSON : </p>
                    <pre>{JSON.stringify(results, null, 2)}</pre>
                </div>
            </div>
        </div>
    );
}
