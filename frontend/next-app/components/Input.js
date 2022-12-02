export default function Input(props) {
    return (
        <label>
            <span className='uppercase'>{props.name}</span>
            <input {...props} />
        </label>
    );
}
